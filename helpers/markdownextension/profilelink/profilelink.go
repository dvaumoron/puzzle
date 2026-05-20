/*
 *
 * Copyright 2023 puzzlemarkdownextension authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

package profilelink

import (
	"bytes"
	"fmt"

	"github.com/yuin/goldmark"
	"github.com/yuin/goldmark/ast"
	"github.com/yuin/goldmark/parser"
	"github.com/yuin/goldmark/renderer"
	"github.com/yuin/goldmark/text"
	"github.com/yuin/goldmark/util"
)

const (
	openStr  = "@["
	openLen  = len(openStr)
	closeStr = "]"
	closeLen = len(closeStr)
	priority = 160
)

// Manage ProfileLink targeting a custom WebComponent "profile-link" :
//   - "@[userLogin]" became <profile-link login="userLogin"></profile-link>
var Extension goldmark.Extender = profileLinkExtender{}
var Kind = ast.NewNodeKind("ProfileLink")

var (
	// check matching with interface
	_ parser.InlineParser   = profileLinkParser{}
	_ renderer.NodeRenderer = profileLinkRenderer{}

	start = []byte{'@'}
	open  = []byte(openStr)
	close = []byte(closeStr)
)

type profileLinkNode struct {
	ast.BaseInline
	Login []byte
}

func (*profileLinkNode) Kind() ast.NodeKind {
	return Kind
}

func (n *profileLinkNode) Dump(src []byte, level int) {
	ast.DumpHelper(n, src, level, map[string]string{
		"Login": string(n.Login),
	}, nil)
}

type profileLinkParser struct{}

func (profileLinkParser) Trigger() []byte {
	return start
}

func (profileLinkParser) Parse(parent ast.Node, block text.Reader, _ parser.Context) ast.Node {
	line, seg := block.PeekLine()
	stop := bytes.Index(line, close)
	if stop < 0 || !bytes.HasPrefix(line, open) {
		return nil
	}

	seg = text.NewSegment(seg.Start+openLen, seg.Start+stop)
	login := block.Value(seg)
	node := &profileLinkNode{Login: bytes.TrimSpace(login)}
	node.AppendChild(node, ast.NewTextSegment(seg))
	block.Advance(stop + closeLen)
	return node
}

type profileLinkRenderer struct{}

func (profileLinkRenderer) RegisterFuncs(reg renderer.NodeRendererFuncRegisterer) {
	reg.Register(Kind, renderWikiLink)
}

func renderWikiLink(writer util.BufWriter, _ []byte, node ast.Node, entering bool) (ast.WalkStatus, error) {
	wikiLink, ok := node.(*profileLinkNode)
	if !ok {
		return ast.WalkStop, fmt.Errorf("unexpected node %T, expected *profileLinkNode", node)
	}

	if entering {
		writer.WriteString("<profile-link login=\"")
		writer.Write(wikiLink.Login)
		writer.WriteString("\">")
	} else {
		writer.WriteString("</profile-link>")
	}

	return ast.WalkContinue, nil
}

type profileLinkExtender struct{}

func (profileLinkExtender) Extend(md goldmark.Markdown) {
	md.Parser().AddOptions(
		parser.WithInlineParsers(
			util.Prioritized(profileLinkParser{}, priority),
		),
	)

	md.Renderer().AddOptions(
		renderer.WithNodeRenderers(
			util.Prioritized(profileLinkRenderer{}, priority),
		),
	)
}

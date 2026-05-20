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

package puzzlemarkdownextension

import (
	"github.com/dvaumoron/puzzlemarkdownextension/profilelink"
	"github.com/dvaumoron/puzzlemarkdownextension/wikilink"
	"github.com/yuin/goldmark"
	"github.com/yuin/goldmark/extension"
	"github.com/yuin/goldmark/renderer/html"
)

func NewDefaultEngine() goldmark.Markdown {
	return goldmark.New(
		goldmark.WithExtensions(extension.GFM, wikilink.Extension, profilelink.Extension),
		goldmark.WithRendererOptions(html.WithHardWraps()),
	)
}

/*
 *
 * Copyright 2023 puzzleweaver authors.
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

package frame

import (
	"context"
	_ "embed"
	"errors"

	"github.com/ServiceWeaver/weaver"
	adminimpl "github.com/dvaumoron/puzzle/weaver/serviceimpl/admin"
	blogimpl "github.com/dvaumoron/puzzle/weaver/serviceimpl/blog"
	customwidgetimpl "github.com/dvaumoron/puzzle/weaver/serviceimpl/customwidget"
	forumimpl "github.com/dvaumoron/puzzle/weaver/serviceimpl/forum"
	loginimpl "github.com/dvaumoron/puzzle/weaver/serviceimpl/login"
	markdownimpl "github.com/dvaumoron/puzzle/weaver/serviceimpl/markdown"
	passwordstrengthimpl "github.com/dvaumoron/puzzle/weaver/serviceimpl/passwordstrength"
	profileimpl "github.com/dvaumoron/puzzle/weaver/serviceimpl/profile"
	saltimpl "github.com/dvaumoron/puzzle/weaver/serviceimpl/salt"
	sessionimpl "github.com/dvaumoron/puzzle/weaver/serviceimpl/session"
	settingsimpl "github.com/dvaumoron/puzzle/weaver/serviceimpl/settings"
	templatesimpl "github.com/dvaumoron/puzzle/weaver/serviceimpl/templates"
	wikiimpl "github.com/dvaumoron/puzzle/weaver/serviceimpl/wiki"
	"github.com/dvaumoron/puzzle/weaver/web/globalconfig"
	"github.com/dvaumoron/puzzle/web/common/build"
)

var (
	errSiteCreation   = errors.New("failure during site creation")
	errStaticCreation = errors.New("failure during static pages creation")
)

// FrameApp is the main component of the application.
// weaver.Run creates it and passes it to frameServe.
type FrameApp struct {
	weaver.Implements[weaver.Main]
	weaver.WithConfig[globalconfig.ParsedConfig]
	web                     weaver.Listener
	sessionService          weaver.Ref[sessionimpl.SessionService]
	templateService         weaver.Ref[templatesimpl.TemplateService]
	settingsService         weaver.Ref[settingsimpl.SettingsService]
	passwordStrengthService weaver.Ref[passwordstrengthimpl.PasswordStrengthService]
	saltService             weaver.Ref[saltimpl.SaltService]
	loginService            weaver.Ref[loginimpl.RemoteLoginService]
	adminService            weaver.Ref[adminimpl.AdminService]
	profileService          weaver.Ref[profileimpl.RemoteProfileService]
	forumService            weaver.Ref[forumimpl.RemoteForumService]
	markdownService         weaver.Ref[markdownimpl.MarkdownService]
	blogService             weaver.Ref[blogimpl.RemoteBlogService]
	wikiService             weaver.Ref[wikiimpl.RemoteWikiService]
	widgetService           weaver.Ref[customwidgetimpl.CustomWidgetService]
}

// FrameServe is called by weaver.Run and contains the body of the application.
func NewFrameServe(version string) func(ctx context.Context, app *FrameApp) error {
	return func(ctx context.Context, app *FrameApp) error {
		logger := app.Logger(ctx)
		globalConfig, err := globalconfig.New(
			app.Config(), app, logger, version, app.sessionService.Get(), app.templateService.Get(), app.settingsService.Get(),
			app.passwordStrengthService.Get(), app.saltService.Get(), app.loginService.Get(), app.adminService.Get(),
			app.profileService.Get(), app.forumService.Get(), app.markdownService.Get(), app.blogService.Get(),
			app.wikiService.Get(), app.widgetService.Get(),
		)
		if err != nil {
			return err
		}

		site, ok := build.BuildDefaultSite(globalConfig)
		if !ok {
			return errSiteCreation
		}

		for _, pageGroup := range globalConfig.StaticPages {
			if !site.AddStaticPages(pageGroup) {
				return errStaticCreation
			}
		}

		if !build.AddWidgetPages(site, ctx, globalConfig.WidgetPages, globalConfig, globalConfig.Widgets) {
			return errSiteCreation
		}

		siteConfig := globalConfig.ExtractSiteConfig()
		// emptying data no longer useful for GC cleaning
		globalConfig = nil

		return site.RunListener(siteConfig, app.web)
	}
}

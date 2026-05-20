# this file is used to configure permission groups and pages with their widget

port = env("SITE_PORT")

availableLocales = ["fr-FR", "en-US"]
dateFormat       = env("DATE_FORMAT")
pageSize         = envAsNumber("PAGE_SIZE")
extractSize      = envAsNumber("EXTRACT_SIZE")

page404Url = "/notFound"

localePicturePaths = ["images/Flag_of_France.webp", "images/Flag_of_the_United_Kingdom.png"]

sessionServiceAddr          = env("SESSION_SERVICE_ADDR")
templateServiceAddr         = env("TEMPLATE_SERVICE_ADDR")
passwordStrengthServiceAddr = env("PASSSTRENGTH_SERVICE_ADDR")
saltServiceAddr             = env("SALT_SERVICE_ADDR")
loginServiceAddr            = env("LOGIN_SERVICE_ADDR")
rightServiceAddr            = env("RIGHT_SERVICE_ADDR")
settingsServiceAddr         = env("SETTINGS_SERVICE_ADDR")
profileServiceAddr          = env("PROFILE_SERVICE_ADDR")
forumServiceAddr            = env("FORUM_SERVICE_ADDR")
markdownServiceAddr         = env("MARKDOWN_SERVICE_ADDR")
blogServiceAddr             = env("BLOG_SERVICE_ADDR")
wikiServiceAddr             = env("WIKI_SERVICE_ADDR")

permission "wikiGroup1" {
  groupId = 2
}

permission "wikiGroup2" {
  groupId = 3
}

permission "blogGroup" {
  groupId = 4
}

permission "forumGroup" {
  groupId = 5
}

# page location ending with / denote a folder (will use the index template)
staticPages {
  groupId   = 0
  locations = ["about/", "about/faq"]
}

widget "wiki1" {
  kind     = "wiki"
  objectId = 1
  groupId  = 2
}

widget "wiki2" {
  kind      = "wiki"
  objectId  = 2
  groupId   = 2
  templates = ["Welcome", "wiki2/view", "wiki2/edit", "wiki2/list"]
}

widget "wiki3" {
  kind     = "wiki"
  objectId = 3
  groupId  = 3
}

widget "blog" {
  kind     = "blog"
  objectId = 4
  groupId  = 4
}

widget "forum" {
  kind     = "forum"
  objectId = 5
  groupId  = 5
}

widget "gallery" {
  kind        = "remote/gallery"
  serviceAddr = env("GALLERY_SERVICE_ADDR")
  objectId    = 6
  groupId     = 0
}

widgetPage "about/wiki" {
  widgetRef = "wiki1"
}

widgetPage "about/faq/wiki2" {
  widgetRef = "wiki2"
}

widgetPage "wiki3" {
  widgetRef = "wiki3"
}

widgetPage "blog" {
  widgetRef = "blog"
}

widgetPage "forum" {
  widgetRef = "forum"
}

widgetPage "gallery" {
  widgetRef = "gallery"
}

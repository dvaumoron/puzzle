# this file is used to configure permission groups and pages with their widget

pageSize   = 3
feedFormat = "rss"

page404Url = "/notFound"

# the first locale item is used as default
locale "fr-FR" {
  picturePath = "images/Flag_of_France.webp"
}

locale "en-US" {
  picturePath = "images/Flag_of_the_United_Kingdom.png"
}

sessionServiceAddr          = "localhost:50051"
templateServiceAddr         = "localhost:51251"
passwordStrengthServiceAddr = "localhost:51151"
saltServiceAddr             = "localhost:50351"
loginServiceAddr            = "localhost:50451"
rightServiceAddr            = "localhost:50251"
settingsServiceAddr         = "localhost:50551"
profileServiceAddr          = "localhost:50651"
forumServiceAddr            = "localhost:50951"
markdownServiceAddr         = "localhost:50851"
blogServiceAddr             = "localhost:51051"
wikiServiceAddr             = "localhost:50751"

# groups with groupId 0 and 1 already exist for public and admin part respectively
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

staticPages {
  groupId   = 0
  hidden    = true
  locations = ["notFound"]
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
  serviceAddr = "localhost:51351"
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

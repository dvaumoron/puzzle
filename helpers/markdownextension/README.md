# puzzlemarkdownextension

[goldmark](https://github.com/yuin/goldmark) extension used in puzzle ecosystem to add [Markdown](https://en.wikipedia.org/wiki/Markdown) syntaxes :

1. wiki link (targeting a  [WebComponent](https://www.webcomponents.org/)) :
    - "[[ pageName ]]" became \<wiki-link title="pageName">pageName\</wiki-link>
    - "[[ pageName | linkName ]]" became \<wiki-link title="pageName">linkName\</wiki-link>
    - "[[ langTag/pageName ]]" became \<wiki-link lang="langTag" title="pageName">pageName\</wiki-link>
    - "[[ path/to/wiki#pageName ]]" became \<wiki-link wiki="path/to/wiki" title="pageName">pageName\</wiki-link>
    - "[[ path/to/wiki#langTag/pageName ]]" became \<wiki-link wiki="path/to/wiki" lang="langTag" title="pageName">pageName\</wiki-link>
    - And so on...

2. profile link (also targeting a WebComponent) :
    - "@[userLogin]" became \<profile-link login="userLogin">\</profile-link>

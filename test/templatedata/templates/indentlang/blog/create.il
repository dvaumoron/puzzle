Import "main"

:= WidgetBody
    Quote
        List
            h2
                (. Messages CreateBlogPostTitle) " "
                a @href=BaseUrl @role="button" (. Messages CancelLinkLabel)

            form @id="previewPostForm" @action=BaseUrl:"preview" @method="POST"
                label
                    . Messages TitleLabel
                    input @type="text" @name="title" @required-message="errorEmptyPostTitleMessage"
                := useMarkdownLabel (. Messages UseMarkdownLabel)
                textarea @name="markdown" @rows="20" @placeholder=useMarkdownLabel @required-message="errorEmptyPostContentMessage" ""
                div @class="hide"
                    # to allow JavaScript or WebAssembly to display a localized error message
                    span @id="errorEmptyPostTitleMessage" (. Messages EmptyPostTitle)
                    span @id="errorEmptyPostContentMessage" (. Messages EmptyPostContent)
                button @type="button" @validate-form="previewPostForm" (. Messages PreviewLinkLabel)

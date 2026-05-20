Import "main"

:= WidgetBody
    Quote
        List
            h2
                (. Messages CreateThreadTitle) " "
                a @href=BaseUrl @role="button" (. Messages CancelLinkLabel)

            form @id="createThreadForm" @action=BaseUrl:"save" @method="POST"
                label
                    (. Messages TitleLabel)
                    input @type="text" @name="title" @required-message="errorEmptyThreadTitleMessage"
                textarea @name="message" @rows="5" @required-message="errorEmptyForumMessageMessage" ""
                div @class="hide"
                    # to allow JavaScript or WebAssembly to display a localized error message
                    span @id="errorEmptyThreadTitleMessage" (. Messages EmptyThreadTitle)
                    span @id="errorEmptyForumMessageMessage" (. Messages EmptyForumMessage)
                button @type="button" @validate-form="createThreadForm" (. Messages CreateLinkLabel)

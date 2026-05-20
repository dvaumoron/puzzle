Import "main"

:= WidgetBody
    Quote
        List
            h2
                (. Thread Text) " "
                a @href=BaseUrl @role="button" (. Messages CancelLinkLabel)

            search (. Messages FilterLabel)
            paginate PreviousPageNumber NextPageNumber Filter

            := threadId (. Thread Id)
            := dateFormat (. Messages DateFormat)
            If AllowedToDelete
                List
                    := deleteLinkLabel (. Messages DeleteLinkLabel)
                    For message ForumMessages
                        div @class="grid"
                            profilePictureLink (. message Creator)
                            div
                                p (date (. message Date) dateFormat)
                                p (EscapeHtml (. message Text))
                            := id (. message Id)
                            p (a @href=BaseUrl:"message/delete/":threadId:"/":id @class="contrast" @role="button" deleteLinkLabel)
                For message ForumMessages
                    div @class="grid"
                        profilePictureLink (. message Creator)
                        div
                            p (date (. message Date) dateFormat)
                            p (EscapeHtml (. message Text))

            If (And AllowedToCreate (Not nextPageNumber))
                form @id="createForumMessageForm" @action=BaseUrl:"message/save/":threadId @method="POST"
                    := responseMessageLabel (. Messages ResponseMessageLabel)
                    textarea @name="message" @rows="5" @placeholder=responseMessageLabel @required-message="errorEmptyForumMessageMessage" ""
                    div @class="hide"
                        # to allow JavaScript or WebAssembly to display a localized error message
                        span @id="errorEmptyForumMessageMessage" (. Messages EmptyForumMessage)
                    button @type="button" @validate-form="createForumMessageForm" @class="secondary" (. Messages PublishLinkLabel)

Import "main"

:= WidgetBody
    Quote
        List
            header
                hgroup
                    h1
                        (. Post Title) " "
                        a @href=BaseUrl @role="button" (. Messages CancelLinkLabel)
                    h3 (. Messages PostAuthorLabel) " " (profileLink (. Post Creator))
                    h3 (. Messages PostDateLabel) " " (date (. Post Date) (. Messages DateFormat))

            div (. Post Content)

            br

            paginate PreviousPageNumber NextPageNumber Filter

            If CommentMsg
                h6 @class="error" ([] Messages CommentMsg)

            := postId (. Post PostId)
            := dateFormat (. Messages DateFormat)
            If AllowedToDelete
                List
                    := deleteLinkLabel (. Messages DeleteLinkLabel)
                    For comment Comments
                        article
                            div @class="grid"
                                profilePictureLink (. comment Creator)
                                div
                                    p (date (. comment Date) dateFormat)
                                    p (EscapeHtml (. comment Text))
                            footer
                                := id (. comment Id)
                                a @href=BaseUrl:"comment/delete/":postId:"/":id @class="contrast" @role="button" deleteLinkLabel
                For comment Comments
                    article
                        div @class="grid"
                            profilePictureLink (. comment Creator)
                            div
                                p (date (. comment Date) dateFormat)
                                p (EscapeHtml (. comment Text))

            If (And AllowedToCreate (Not nextPageNumber))
                form @id="commentForm" @action=BaseUrl:"comment/save/":postId @method="POST"
                    := leaveCommentLabel (. Messages LeaveCommentLabel)
                    textarea @name="comment" @rows="5" @placeholder=leaveCommentLabel @required-message="errorEmptyCommentMessage" ""
                    div @class="hide"
                        # to allow JavaScript or WebAssembly to display a localized error message
                        span @id="errorEmptyCommentMessage" (. Messages EmptyComment)
                    button @type="button" @validate-form="commentForm" @class="secondary" (. Messages PublishLinkLabel)

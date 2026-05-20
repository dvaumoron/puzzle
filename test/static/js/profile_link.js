class ProfileLink extends HTMLElement {
    constructor() {
        super();

        var login = this.getAttribute("login");

        var shadow = this.attachShadow({ mode: 'open' });
        var loadBloc = document.createElement('span');
        fetch('/profile/link/' + login + '?pagePart=body')
            .then(reponse => reponse.text())
            .then(data => loadBloc.innerHTML = data)
        shadow.appendChild(loadBloc);
    }
}

customElements.define('profile-link', ProfileLink);

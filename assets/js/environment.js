// -------------------- Header and Title --------------------

var Header = React.createClass({
    render: function() {
        var headerRowStyle = {
            backgroundImage: "url('assets/images/backgrounds/skulls.png')"
        };
        
        return (
            <header className="mdl-layout__header mdl-layout__header--transparent">
              <div className="mdl-layout__header-row"
                   style={headerRowStyle}>
                <span className="mdl-layout-title">{"Ping's Monster Hunter Dex"}</span>
              </div>
            </header>
        );
    }
});

// The drawer on the top-left corner. It does nothing than showing
// some useless content right now.
var Drawer = React.createClass({
    render: function() {
        return (
            <div className="mdl-layout__drawer">
              <span className="mdl-layout-title">{"Bang! Nothing here ^_^"}</span>
            </div>
        );
    }
});



// -------------------- Navigation --------------------

var NavigationItem = React.createClass({
    render: function() {
        var iconStyle = {
            backgroundImage: "url('assets/images/navigations/" + 
                this.props.icon + ".png')"
        };
        
        return (
            <a href={this.props.page} className="app-nav-link">
              <div className="app-nav-icon" 
                   style={iconStyle}>
              </div>
              <span>{this.props.caption}</span>
            </a>
        );
    }
});

var Navigation = React.createClass({
    render: function() {
        return (
            <aside className="app-nav mdl-shadow--4dp">
              <NavigationItem caption="Monster" icon="monster" page="#monster-page"/>
              <NavigationItem caption="Weapon" icon="lance" page="#weapon-page"/>
              <NavigationItem caption="Armor" icon="armor" page="#armor-page"/>
              <NavigationItem caption="Map" icon="map" page="#map-page"/>
              <NavigationItem caption="Quest" icon="quest" page="#quest-page"/>
              <NavigationItem caption="Item" icon="item" page="#item-page"/>
              <NavigationItem caption="Searcher" icon="question" page="#searcher-page"/>
              <NavigationItem caption="Misc" icon="misc" page="#misc-page"/>
              <NavigationItem caption="About" icon="dragon" page="#about-page"/>
            </aside>
        );
    }
});



// -------------------- Footer --------------------

var Footer = React.createClass({
    render: function() {
        return (
            <footer className="mdl-mini-footer mdl-color--grey-900">
              <ul>
                <li className="mdl-mini-footer--social-btn">
                  <a href="https://github.com/breakds" role="button" title="GitHub"></a>
                </li>
              </ul>
            </footer>
        );
    }
});

var Page = React.createClass({
    // Properties:
    //
    //   activePage: this page is only active when activePage equals
    //               its name.
    // 
    //   name: the name of the page that will be used to refer the page.
    
    render: function() {
        var pageSectionStyle = {
            minHeight: 1000
        }
        return (
            <section id={this.props.name} 
                     className={"app-page-view mdl-layout__tab-panel mdl-grid" + 
                                ((this.props.activePage == this.props.name) ? " is-active" : "")}
                     style={pageSectionStyle}>
              {(this.props.activePage == this.props.name) ? (
                <div className="mdl-cell mdl-cell--12-col">
                  {this.props.children ?
                   this.props.children :
                   // Put a button to indicate that this page is not yet implemented.
                   <button className="mdl-button mdl-js-button mdl-button--raised mdl-button--accent mdl-js-ripple-effect"
                           ref="button">
                     {this.props.name + " not implemented"}
                   </button>}
                </div>) : (<div></div>)}
            </section>
        );
    }
});

var Page = React.createClass({
    // Properties:
    //
    //   isActive: whether the page is active (in terms of
    //             mdl-layout__tab-panel).
    // 
    //   id: the name of the page that will be used to refer the page.
    render: function() {
        var pageSectionStyle = {
            minHeight: 1000
        }
        return (
            <section id={this.props.id} 
                     className={"app-page-view mdl-layout__tab-panel mdl-grid" + 
                                (this.props.isActive ? " is-active" : "")}
                     style={pageSectionStyle}>
              <div className="mdl-cell mdl-cell--12-col">
                {this.props.children}
              </div>
            </section>
        );
    }
});

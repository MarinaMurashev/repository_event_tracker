import React from "react";

class Actor extends React.Component {
  constructor () {
    super();
    this.state = {
      actor: {}
    };
  }

  setActor () {
    this.setState({ actor: this.props.actor });
  }

  componentDidMount () {
    this.setActor();
  }

  componentWillReceiveProps (nextProps) {
    this.setActor();
  }

  render () {
    const actor = this.state.actor;

    if(actor) {
      return (
        <div>
          <div>{`id: ${actor.id}`}</div>
          <div>{`id: ${actor.login}`}</div>
          <div>{`id: ${actor.display_login}`}</div>
          <div>{`id: ${actor.gravatar_id}`}</div>
          <div>{`id: ${actor.url}`}</div>
          <div>{`id: ${actor.avatar_url}`}</div>
        </div>
      );
    } else {
      return(<div></div>)
    }
  }
}

export default Actor;

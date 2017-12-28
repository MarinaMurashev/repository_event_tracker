import React from "react";

class Actor extends React.Component {
  constructor () {
    super();
    this.state = {
      actor: {}
    };
  }
  componentDidMount () {
    this.setState({ actor: this.props.actor });
  }

  componentWillReceiveProps (nextProps) {
    this.setState({ actor: nextProps.actor });
  }

  render () {
    const actor = this.state.actor;

    if(actor) {
      return (
        <div>
          <div>{`id: ${actor.id}`}</div>
          <div>{`login: ${actor.login}`}</div>
          <div>{`display_login: ${actor.display_login}`}</div>
          <div>{`gravatar_id: ${actor.gravatar_id}`}</div>
          <div>{`actor_url: ${actor.url}`}</div>
          <div>{`actor_avatar_url: ${actor.avatar_url}`}</div>
        </div>
      );
    } else {
      return(<div></div>)
    }
  }
}

export default Actor;

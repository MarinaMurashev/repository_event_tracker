import React from "react";
import Actor from "./Actor"

class Event extends React.Component {
  constructor () {
    super();
    this.state = {
      event: {}
    };
  }

  componentDidMount () {
    this.setState({ event: this.props.event });
  }

  componentWillReceiveProps (nextProps) {
    this.setState({ event: nextProps.event });
  }

  render () {
    const event = this.state.event
    const actor = event.actor

    return (
      <div>
        <div>{`id: ${event.id}`}</div>
        <div>{`type: ${event.type}`}</div>
        <div><Actor actor={actor}/></div>
        <div>{`created_at: ${event.created_at}`}</div>
      </div>
    );
  }
}

export default Event;

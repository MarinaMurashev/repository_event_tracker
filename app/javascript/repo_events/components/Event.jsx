import React from "react";
import Actor from "./Actor"

class Event extends React.Component {
  constructor () {
    super();
    this.state = {
      event: {}
    };
  }

  setEvent () {
    this.setState({ event: this.props.event });
  }

  componentDidMount () {
    this.setEvent();
  }

  componentWillReceiveProps (nextProps) {
    this.setEvent();
  }

  render () {
    const event = this.state.event

    return (
      <div>
        <div>{`id: ${event.id}`}</div>
        <div>{`type: ${event.type}`}</div>
        <div><Actor actor={event.actor}/></div>
        <div>{`created_at: ${event.created_at}`}</div>
      </div>
    );
  }
}

export default Event;

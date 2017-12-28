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
      <tr>
        <td>{event.id}</td>
        <td>{event.type}</td>
        <td><Actor actor={actor}/></td>
        <td>{event.created_at}</td>
      </tr>
    );
  }
}

export default Event;

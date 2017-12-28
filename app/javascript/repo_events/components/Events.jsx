import React from "react";
import { Table } from "react-bootstrap";
import Event from "./Event"

class Events extends React.Component {
  constructor () {
    super();
    this.state = {
      events: []
    };
  }

  componentDidMount () {
    this.setState({ events: this.props.events });
  }

  componentWillReceiveProps (nextProps) {
    this.setState({ events: nextProps.events });
  }

  render () {
    const events = this.state.events

    return (
      <Table striped bordered condensed hover>
        <thead>
          <tr>
            <th>id</th>
            <th>type</th>
            <th>actor</th>
            <th>created_at</th>
          </tr>
        </thead>
        <tbody>
          {
            events.map((event, i) => {
              return ( <Event event={event} /> )
            })
          }
        </tbody>
      </Table>
    );
  }
}

export default Events;

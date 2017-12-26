import React from "react";
import axios from "axios";

class RepoEventsDisplay extends React.Component {
  constructor () {
    super();
    this.state = {
      events: []
    };
  }

  fetchEvents () {
    axios.get(`api/v1/repo_events`)
      .then(response => {
        this.setState({ events: response.data });
      })
      .catch(error => {
        console.error(error);
      });
  }

  componentDidMount () {
    this.fetchEvents();
  }

  componentWillReceiveProps (nextProps) {
    this.fetchEvents();
  }

  render () {
    const events = this.state.events

    return (
      <div>
        {
          events.map((event, i) => {
            return (
              <p>{event && `${event.id}`}</p>
            )
          })
        }
      </div>
    );
  }
}

export default RepoEventsDisplay;

import React from "react";
import axios from "axios";
import Event from "./Event"

class RepoEventsDisplay extends React.Component {
  constructor () {
    super();
    this.state = {
      events: []
    };
  }

  fetchEvents (user, repoName) {
    axios.get(`api/v1/repo_events?user=${user}&repo_name=${repoName}`)
      .then(response => {
        this.setState({ events: response.data });
      })
      .catch(error => {
        console.error(error);
      });
  }

  setUser () {
    this.setState({ user: this.props.defaultUser });
  }

  setRepoName () {
    this.setState({ repoName: this.props.defaultRepoName });
  }

  componentDidMount () {
    this.setUser();
    this.setRepoName();
    this.fetchEvents(this.props.defaultUser, this.props.defaultRepoName);
  }

  componentWillReceiveProps (nextProps) {
    this.setUser();
    this.setRepoName();
    this.fetchEvents(this.props.defaultUser, this.props.defaultRepoName);
  }

  render () {
    const events = this.state.events
    const user = this.state.user
    const repoName = this.state.repoName

    return (
      <div>
        <div>{`User: ${user}, Repo Name: ${repoName}`}</div>
        {
          events.map((event, i) => {
            return ( <Event event={event} /> )
          })
        }
      </div>
    );
  }
}

export default RepoEventsDisplay;

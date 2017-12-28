import React from "react";
import axios from "axios";
import { Form, FormGroup, ControlLabel, FormControl, Button } from "react-bootstrap";
import Events from "./Events"

class RepoEventsDisplay extends React.Component {
  constructor () {
    super();
    this.state = {
      events: [],
      user: '',
      repoName: '',
      eventType: ''
    };
  }

  fetchEvents (user, repoName, eventType) {
    axios.get(`api/v1/repo_events?user=${user}&repo_name=${repoName}&event_type=${eventType || ''}`)
      .then(response => {
        this.setState({ user: user, repoName: repoName, eventType: eventType, events: response.data });
      })
      .catch(error => {
        console.error(error);
      });
  }

  componentDidMount () {
    this.setState({
      repoName: this.props.defaultRepoName,
      user: this.props.defaultUser,
    });
    this.fetchEvents(this.props.defaultUser, this.props.defaultRepoName);
  }

  handleChange (e) {
    let newState = {
      events: this.state.events,
      user: this.state.user,
      repoName: this.state.repoName,
      eventType: this.state.eventType
    };

    newState[e.target.name] = e.target.value;

    this.setState(newState);
  }

  handleSubmit (e, message) {
    e.preventDefault();

    let user = this.state.user;
    let repoName = this.state.repoName;
    let eventType = this.state.eventType;
    this.fetchEvents(user, repoName, eventType);
  }

  render () {
    const events = this.state.events
    const user = this.state.user
    const repoName = this.state.repoName
    const eventType = this.state.eventType

    return (
      <div>
        <Form onSubmit={this.handleSubmit.bind(this)}>
          <FormGroup>
            <ControlLabel>User</ControlLabel>
            <FormControl type="text" name="user" placeholder={user} onChange={this.handleChange.bind(this)} />
          </FormGroup>

          <FormGroup>
            <ControlLabel>Repo Name</ControlLabel>
            <FormControl type="text" name="repoName" placeholder={repoName} onChange={this.handleChange.bind(this)} />
          </FormGroup>

          <FormGroup>
            <ControlLabel>Event Type</ControlLabel>
            <FormControl type="text" name="eventType" placeholder={eventType || 'all'} onChange={this.handleChange.bind(this)} />
          </FormGroup>
          <Button type="submit">Fetch Events</Button>
        </Form>
        <p></p>
        <Events events={events} />
      </div>
    );
  }
}

export default RepoEventsDisplay;

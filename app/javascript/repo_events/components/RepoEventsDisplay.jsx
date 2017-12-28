import React from "react";
import axios from "axios";
import Event from "./Event"

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
        <form className='react-form' onSubmit={this.handleSubmit.bind(this)}>
          <fieldset className='form-group'>
           <input id='formUser' className='form-input' name='user' type='text' required onChange={this.handleChange.bind(this)} />
          </fieldset>

          <fieldset className='form-group'>
           <input id='formRepoName' className='form-input' name='repoName' type='text' required onChange={this.handleChange.bind(this)}  />
          </fieldset>

          <fieldset className='form-group'>
           <input id='formRepoName' className='form-input' name='eventType' type='text' onChange={this.handleChange.bind(this)}  />
          </fieldset>

          <div className='form-group'>
           <input id='formButton' className='btn' type='submit' placeholder='Fetch Events' />
          </div>
        </form>
        <div>{`User: ${user}, Repo Name: ${repoName}, Event Type: ${eventType || 'all'}`}</div>
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

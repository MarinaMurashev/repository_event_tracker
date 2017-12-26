import React from 'react'
import {
  BrowserRouter as Router,
  Route
} from 'react-router-dom'
import RepoEventsDisplay from './RepoEventsDisplay'

const App = (props) => (
  <Router>
    <div>
      <Route
        path="/"
        defaultUser={props.defaultUser}
        defaultRepoName={props.defaultRepoName}
        render={(routeProps) => <RepoEventsDisplay {...props} {...routeProps} />}
      />
    </div>
  </Router>
)

export default App

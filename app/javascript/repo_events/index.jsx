import React from "react";
import ReactDOM from "react-dom";
import App from "./components/App";

const repo_events = document.querySelector("#repo_events")
ReactDOM.render(
  <App
    defaultUser={repo_events.dataset.defaultUser}
    defaultRepoName={repo_events.dataset.defaultRepoName}
  />,
  repo_events
);

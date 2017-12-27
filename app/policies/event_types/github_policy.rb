module EventTypes
  class GithubPolicy
    TYPES = %w(
      CommitCommentEvent
      CreateEvent
      DeleteEvent
      DeploymentEvent
      DeploymentStatusEvent
      DownloadEvent
      FollowEvent
      ForkEvent
      ForkApplyEvent
      GistEvent
      GollumEvent
      InstallationEvent
      InstallationRepositoriesEvent
      IssueCommentEvent
      IssuesEvent
      LabelEvent
      MarketplacePurchaseEvent
      MemberEvent
      MembershipEvent
      MilestoneEvent
      OrganizationEvent
      OrgBlockEvent
      PageBuildEvent
      ProjectCardEvent
      ProjectColumnEvent
      ProjectEvent
      PublicEvent
      PullRequestEvent
      PullRequestReviewEvent
      PullRequestReviewCommentEvent
      PushEvent
      ReleaseEvent
      RepositoryEvent
      StatusEvent
      TeamEvent
      TeamAddEvent
      WatchEvent
    ).freeze

    def self.valid?(type)
      TYPES.include?(type)
    end
  end
end

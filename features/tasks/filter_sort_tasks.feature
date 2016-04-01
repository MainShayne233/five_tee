@javascript

Feature:
  Users should be able to filter and sort tasks

  Background:
    Given I have an account
    And I have a task
    And I log in
    And my browser is full screen


  Scenario: Filters and sort tasks
    When I create another task
    And I refresh
    When I set the current task to task "1"
    When I filter by the task's tag
    Then I should only see the task
    When I set the current task to task "2"
    When I filter by the task's tag
    Then I should only see the task
    When I filter by All Tags
    And I sort by "Oldest to Newest"
    When I set the current task to task "1"
    Then I should see the task first
    When I sort by "Newest to Oldest"
    When I set the current task to task "2"
    Then I should see the task first

# Gitlab webhook info "printer"

Print informations from gitlab (webhook) to IRC/hipchat.

Based on [omribahumi](https://github.com/github/hubot-scripts/blob/dfce94f7abf61930774a5ae38e46e83d85abf323/src/scripts/gitlab.coffee) script.

Only web hook with very simple informations:

```
"#{hook.user_name} pushed a new branch: [#{branch}]"
```

```
"#{hook.user_name} pushed #{hook.total_commits_count} commits to [#{branch}]"
```

#Plans:
- add support for gitlab API commands like getting list of merge requests

# License

Licensed under the [MIT license](http://opensource.org/licenses/MIT).
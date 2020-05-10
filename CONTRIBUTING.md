# Contributing
When contributing to this repository, please first discuss the change you wish
to make via issue, email, or any other method with the owners of this repository
before making a change.

## Coding rules
### Basics
[Effective Dart](https://dart.dev/guides/language/effective-dart)

### Nesting Flutter's widgets
Put a comma: ```,``` after ***every possible*** round or square closing bracket:
```)```, ```]``` or sometimes after a curly one, if possible: ```}```. Also put
it after ***every*** keyword argument and, e.g. list member or function argument
in longer (multiline) expressions.

### Formatting
Run ```flutter format lib/ test/``` in the root project directory.

## Pull Request Process
Workflow style: [TBD](https://trunkbaseddevelopment.com/) with short-lived
feature branches.
1. Ensure any install or build dependencies are removed before the end of the
   layer when doing a build.
2. Create an issue and stick it to the 'Doing' column in the GitLab Issues
   Boards.
3. Create a branch named like: ```your-nickname/feature-name-on-issue-boards```.
4. Update the CHANGELOG.md with your changes.
5. Push your branch.
6. Create a merge request to ```master```.
7. After an aprovval and merge, your issue will be marked as 'Done' by
   a maintainer.
8. The versioning scheme we use is [SemVer](http://semver.org/).

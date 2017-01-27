# Project 1 - Flicks

Flicks is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: 40 hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can view a list of movies currently playing in theaters. Poster images load asynchronously.
- [x] User can view movie details by tapping on a cell.
- [x] User sees loading state while waiting for the API.
- [x] User sees an error message when there is a network error.
- [x] User can pull to refresh the movie list.
- [x] Add a tab bar for **Now Playing** and **Top Rated** movies.
- [x] Implement segmented control to switch between list view and grid view.

The following **optional** features are implemented:

- [ ] Add a search bar.
- [ ] All images fade in.
- [ ] For the large poster, load the low-res image first, switch to high-res when complete.
- [ ] Customize the highlight and selection effect of the cell.
- [x] Customize the navigation bar.
- [ ] Tapping on a movie poster image shows the movie poster as full screen and zoomable.
- [ ] User can tap on a button to play the movie trailer.

The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='chaglerFlicks.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

The biggest technical challenge was handling the programmatic sizing of the contentView which contains the
description of the movie in the detail view.  That does not appear to behave consistently from one run
to another, causing it to produce different results for different movies.  Repeated sessions of trying to
dig through different ways of handling that, even with the instructor's help, did not produce consistent
results.  The biggest challenge otherwise was that the course materials are all prepared for it to be
taught in swift, and this course is being taught in objective-C.  It would be much more successful if we
were working with links to examples that were using the same language we are using.  Since this is not the
first time this course has been conducted in this language like this, I am shocked to find such gaping 
holes in the materials.  They have slowed us down this week quite a bit.

## License

    Copyright [2017] [Carol Hagler]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

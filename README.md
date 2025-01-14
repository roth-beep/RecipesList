### Summary: 
![Screenshot](/Users/sahilreddy/Desktop/RecipesList/screenshot.png)

### Focus Areas:
 - I took this as an opportunity to focus on some newer features with Swift including Actors, SwiftData and Testing frameworks. This is because I rarely get the opportunity to experiment with these in my day to day. However, I decided to leave out SwiftData because it would conflict with the requirements. Using it with MVVM can look awkward, and it also suffers from the common issues seen in newly introduced iOS libraries.

### Time Spent: 
 - I spent a couple hours on the SwiftData work but when I decided to cut it because of the issues listed above, I was able to move more smoothly and just take the code I already written and start porting it over. After that it was probably another 3-4 hours plus an extra hour or so I spent today looking over the code and doing any minor clean up and writing this README. I'm not sure though I didn't keep track.

### Trade-offs and Decisions:
 Yes there are definitely tradeoffs made in the interest of time. 
 - I didn't test the ImageLoader or the Fetcher because that would've take longer to set all of the required items.
 - Piggybacking off the last point: FileManager should've been hidden under our own type in order to make it more user friendly and add more testability
 - I realized towards the end I didn't test our RecipeCardViewModel, but that would've been a similar test to the other tests already shown so in the interest of time I cut that out.
 - We are just fetching "all recipes" every time. So it's not set up at all to handle more complex operations that are usually seen in an enterprise app.
 - The addition of CoreData would've been nice but I felt like it conflicted with the requirements and again there is a time constraint.
 - Recipe type should've really been converted to a type our scene used considering in this we only used uuid, cuisine, name, and photoURLSmall. Plus it's better design wise for limiting the scene to only what it's concerned with. Maybe another type called RecipeMetaData?
 - More file separation would be nice but it's a smaller project and I didn't want to spend too much time on that.

### Weakest Part of the Project: 

 - The weakest part is definitely the UI. I chose not to dedicate much time to this beyond the basic list. In my experience, the day-to-day value of assisting a designer wouldn't really be captured from this and the "show-off" designs usually take a lot longer time so I don't think that's what is being looked for here.


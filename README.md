# Sorting-Algorithms-Live-Coding-Toolbox
A library of functions based on 4 different sorting algorithms with customized parameters for using them in performance.

## Documentation

Each sorting function is highly customizable. They come with default values that can be modified
and changed on the fly through keyword arguments.

### BUBBLE SORT

`list: DEFAULT_LIST_BUBBLE`
Default list used if no other list is passed. Defined in the helpers file.

`sorted: DEFAULT_SORTED`
The function to execute once the list is sorted. Defaults to the function defined in the helpers file.

`amp: 1`
Master volume of the function. Defaults to 1.

`play_list: true`
Indicates if the unsorted list should be played before executing the sorting.
Defaults to `true`.

`synth: :sine`
Synth to be used by the function. Defaults to `:sine`.

`drums: {:bd => :bd_tek, :cyms => :drum_cymbal_closed}`
The drums or percussions used by the function. Defaults are listed above.

`sleep: 0.25`
Sleep time between each sound. Defaults to `0.25`.

`drums_amp: 0`
Volume control for the drums or percussions. This argument doesn't give a new amplitude value, it adjusts the amplitude value
by the number given and applies it on each percussive sample. So for example, if the amp value is 1 and the value for
`drums_amp` is -0.3, the amp of the drums will be 1 - 0.3. Accepts both positive and negative values.
Default value is 0.

`bleeps_amp: 0`
Same as `drums_amp` but applied on the `:elec_blip2` sample that is used by the function. _Note: This sample is the only one that can't be changed dynamically in the arguments._

`synths_amp: 0`
Same as `drums_amp` and `bleeps_amp` but applied on the synths.

`shutup_drums: false`
If `true`, sets the volume of drums and percussions to 0. Default is `false`.

`shutup_synths: false`
If `true`, sets the volume of the synths to 0. Default is `false`.

`shutup_bleeps: false`
If `true`, sets the volume of the `:elec_blip2` sample to 0. Default is `false`.

`silence: false`
If `true`, sets the volume of all samples and synths to 0. Default is `false`.


### SELECTION SORT

`list: DEFAULT_LIST_SELECT_INSERT`
Default list used if no other list is passed. Defined in the helpers file.

`amp: 1`
Master volume of the function. Defaults to 1.

`play_list: true`
Indicates if the unsorted list should be played before executing the sorting.
Defaults to `true`.

`sleep: 0.125`
Sleep time between each sound. Defaults to `0.25`.

`shutup_drums: false`
If `true`, sets the volume of drums and percussions to 0. Default is `false`.

`shutup_synths: false`
If `true`, sets the volume of the synths to 0. Default is `false`.

`drums: {:bd => :bd_tek, :cyms => :drum_cymbal_closed, :sn => :drum_snare_soft}`
The drums or percussions used by the function. Defaults are listed above.

`synths: {:main => :sine, :opt => :tb303}`
Synths to be used by the function. Defaults are listed above.

`sorted: DEFAULT_SORTED`
The function to execute once the list is sorted. Defaults to the function defined in the helpers file.

`drums_amp: 0`
Volume control for the drums or percussions. This argument doesn't give a new amplitude value, it adjusts the amplitude value by the number given and applies it on each percussive sample. So for example, if the amp value is 1 and the value for `drums_amp` is -0.3, the amp of the drums will be 1 - 0.3. Accepts both positive and negative values.
Default value is 0.

`synths_amp: 0`
Same as `drums_amp` but applied on the synths.

`silence: false`
If `true`, sets the volume of all samples and synths to 0. Default is `false`.

### INSERTION SORT

`list: DEFAULT_LIST_SELECT_INSERT`
Default list used if no other list is passed. Defined in the helpers file.

`sorted: DEFAULT_SORTED`
The function to execute once the list is sorted. Defaults to the function defined in the helpers file.

`amp: 1`
Master volume of the function. Defaults to 1.

`play_list: true`
Indicates if the unsorted list should be played before executing the sorting.
Defaults to `true`.

`drums: {:bd => :bd_tek, :cyms => :drum_cymbal_closed, :sn => :drum_splash_soft}`
The drums or percussions used by the function. Defaults are listed above.

`synths: {:main => :sine, :opt1 => :tri, :opt2 => :square}`
Synths to be used by the function. Defaults are listed above.

`sleep: 0.125`
Sleep time between each sound. Defaults to `0.25`.

`shutup_drums: false`
If `true`, sets the volume of drums and percussions to 0. Default is `false`.

`shutup_synths: false`
If `true`, sets the volume of the synths to 0. Default is `false`.

`drums_amp: 0`
Volume control for the drums or percussions. This argument doesn't give a new amplitude value, it adjusts the amplitude value by the number given and applies it on each percussive sample. So for example, if the amp value is 1 and the value for `drums_amp` is -0.3, the amp of the drums will be 1 - 0.3. Accepts both positive and negative values.
Default value is 0.

`synths_amp: 0`
Same as `drums_amp` but applied on the synths.

`silence: false`
If `true`, sets the volume of all samples and synths to 0. Default is `false`.

### MERGE SORT

_Note: Since merge sort works recursively, the options are a bit different._

`list: DEFAULT_LIST_MERGE`
Default list used if no other list is passed. Defined in the helpers file.

`side: nil`
Since merge sort is a 'divide and conquer' algorithm, this argument indicates to the function which side of the list
we are presently looking at. It's meant for internal use by the function and shouldn't be changed dynamically in order
for the algorithm to work correctly.

`sorted: DEFAULT_SORTED`
The function to execute once the list is sorted. Defaults to the function defined in the helpers file.

`run_sorted: true`
Since merge sort is a recursive function, the sorted function will run every time the list gets sorted during one
of the recursive calls. This means that the function will run even though we haven't sorted the final list yet but
each time a 'sublist' gets sorted. To avoid too many unnecessary calls to the sorted function, merge sort is designed
to run the sorted function only if the list it's presently sorting has more then 3 elements. This argument allows
to decide whether we want to run the sorted function or not.
Defaults to `true`.

`amp: 1`
Master volume of the function. Defaults to 1.

`sleep: 0.25`
Sleep time between each sound. Defaults to `0.25`.

`synths: {:main => :square, :opt => :beep}`
Synths to be used by the function. Defaults are listed above.

`percs: {:opt1 => :elec_flip, :opt2 => :elec_plip, :opt3 => :ambi_swoosh}`
The drums or percussions used by the function. Defaults are listed above.

`shutup_synths: false`
If `true`, sets the volume of the synths to 0. Default is `false`.

`shutup_percs: false`
If `true`, sets the volume of drums and percussions to 0. Default is `false`.

`percs_amp: 0`
Volume control for the percussions and ambient sounds. This argument doesn't give a new amplitude value, it adjusts the amplitude value by the number given and applies it on each percussive and ambient sample. So for example, if the amp value is 1 and the value for `percs_amp` is -0.3, the amp of the percussive or ambient samples will be 1 - 0.3. Accepts both positive and negative values.
Default value is 0.

`synths_amp: 0`
Same as `percs_amp` but applied on the synths.

`silence: false`
If `true`, sets the volume of all samples and synths to 0. Default is `false`.

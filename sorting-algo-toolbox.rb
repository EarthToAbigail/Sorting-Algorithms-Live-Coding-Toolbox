# BUBBLE SORT
def bubble_sort(list: DEFAULT_LIST_BUBBLE, sorted: DEFAULT_SORTED, amp: 1, play_list: true, synth: :sine,
                drums: {:bd => :bd_tek, :cyms => :drum_cymbal_closed}, sleep: 0.25, shutup_drums: false,
                drums_amp: 0, bleeps_amp: 0, synths_amp: 0, shutup_synths: false,
                shutup_bleeps: false, silence: false)

  arr = list.dup
  swapped = false
  r = arr.length - 2
  num_iters = 0

  use_synth synth
  if play_list
    arr.each { |n|
      play n, amp: silence ? 0 : amp + synths_amp < 0 ? 0 : amp + synths_amp, release: 0.2
      sleep sleep
    }
  end

  while true
    swaps = 0
    num_iters += 1

    in_thread do
      sample drums[:bd], amp: silence ? 0 : shutup_drums ? 0 : amp + 0.5 + drums_amp < 0 ? 0 : amp + 0.5 + drums_amp
    end

    in_thread do
      num_iters.times do |i|
        sample drums[:cyms], amp: silence ? 0 : shutup_drums ? 0 : amp + (i.to_f / 2.0) + drums_amp < 0 ? 0 : amp + (i.to_f / 2.0) + drums_amp, rate: 2
        sleep (2.0 / num_iters).round(2)
      end
    end

    for i in 0..r
      play arr[i], amp: silence ? 0 : shutup_synths ? 0 : amp + synths_amp < 0 ? 0 : amp + synths_amp, release: 0.1
      sleep sleep
      if arr[i] > arr[i+1]
        arr[i], arr[i+1] = arr[i+1], arr[i]
        swapped = true if !swapped
        sample :elec_blip2, amp: silence ? 0 : shutup_bleeps ? 0 : amp + 0.5 + bleeps_amp < 0 ? 0 : amp + 0.5 + bleeps_amp
        sleep sleep
        play arr[i], amp: silence ? 0 : shutup_synths ? 0 : amp + synths_amp < 0 ? 0 : amp + synths_amp
        sleep sleep
        swaps += 1
      end
    end
    swapped ? swapped = false : break
  end

  if not silence
    sorted.call(arr, "Bubble Sort")
  end
end

# SELECTION SORT
def selection_sort(list: DEFAULT_LIST_SELECT_INSERT, amp: 1, play_list: true, sleep: 0.125, shutup_drums: false, shutup_synths: false, silence: false,
                   drums: {:bd => :bd_tek, :cyms => :drum_cymbal_closed, :sn => :drum_snare_soft},
                   synths: {:main => :sine, :opt => :tb303}, sorted: DEFAULT_SORTED,
                   drums_amp: 0, synths_amp: 0)

  arr = list.dup
  r = arr.length - 1
  swaps = 0

  use_synth synths[:main]
  if play_list
    arr.each {|n| play n, amp: silence ? 0 : amp + synths_amp < 0 ? 0 : amp + synths_amp, release: 0.3; sleep sleep * 2}
  end

  for i in 0..r
    min = arr[i]
    min_idx = i

    sample drums[:bd], amp: silence ? 0 : shutup_drums ? 0 : amp * 2 + drums_amp < 0 ? 0 : amp * 2 + drums_amp

    use_synth synths[:main]
    sub = arr[i+1..-1].reverse
    sub.each { |n|
      play n, amp: silence ? 0 : shutup_synths ? 0 : amp + synths_amp < 0 ? 0 : amp + synths_amp, release: 0.02, cutoff: 60, decay: 0.05
      sleep sleep
    }

    replacements = 0
    for j in (i + 1)..r
      if arr[j] < min
        min = arr[j]
        min_idx = j
        replacements += 1
      end
    end

    in_thread do
      replacements.times do
        sample drums[:cyms], rate: 2, amp: silence ? 0 : shutup_drums ? 0 : amp + 0.3 + drums_amp < 0 ? 0 : amp + 0.3 + drums_amp
        sleep sleep
      end
    end

    in_thread do
      if min_idx != i
        arr[i], arr[min_idx] = arr[min_idx], arr[i]
        swaps += 1
        use_synth synths[:opt]
        play arr[min_idx], amp: silence ? 0 : shutup_synths ? 0 : amp / 2.0 + synths_amp < 0 ? 0 : amp / 2.0 + synths_amp, sustain: 0.1, decay: 0.2, release: 0.1, cutoff: 60
      else
        sample drums[:sn], amp: silence ? 0 : 2, rate: -1
      end
    end

    use_synth synths[:opt]
    sl = list.length * sleep > 2 ? 4 - (sub.length * sleep) : 2 - (sub.length * sleep)
    play arr[i], amp: silence ? 0 : shutup_synths ? 0 : amp / 2.0 + synths_amp < 0 ? 0 : amp / 2.0 + synths_amp, cutoff: 70, sustain: 0.1, decay: 0.2, release: 0.1
    sleep sl
  end

  if not silence
    sorted.call(arr, "Selection Sort")
  end
end

# INSERTION SORT
def insertion_sort(list: DEFAULT_LIST_SELECT_INSERT, sorted: DEFAULT_SORTED, amp: 1, play_list: true,
                   drums: {:bd => :bd_tek, :cyms => :drum_cymbal_closed, :sn => :drum_splash_soft}, sleep: 0.125,
                   synths: {:main => :sine, :opt1 => :tri, :opt2 => :square}, shutup_drums: false,
                   shutup_synths: false, silence: false, drums_amp: 0, synths_amp: 0)

  arr = list.dup
  r = arr.length - 1
  swaps = 0

  use_synth synths[:main]
  if play_list
    arr.each {|n|
      play n, amp: silence ? 0 : amp + synths_amp < 0 ? 0 : amp + synths_amp, release: 0.3
      sleep sleep * 2
    }
  end

  for i in 1..r
    sample drums[:bd], amp: silence ? 0 : shutup_drums ? 0 : amp * 2 + drums_amp < 0 ? 0 : amp * 2 + drums_amp
    key = arr[i]
    j = i - 1

    overwrites = 0
    while j >= 0 and arr[j] > key
      arr[j + 1] = arr[j]
      j -= 1
      overwrites += 1
    end

    note_swapped = false
    if arr[j+1] != key
      note_swapped = arr[j+1]
      arr[j+1] = key
      swaps += 1
    else
      sample drums[:sn], amp: silence ? 0 : shutup_drums ? 0 : amp + 0.5 + drums_amp < 0 ? 0 : amp + 0.5 + drums_amp, rate: -1
    end

    in_thread do
      sleep 1
      overwrites.times do
        sample drums[:cyms], rate: 2, amp: silence ? 0 : shutup_drums ? 0 : amp + 0.3 + drums_amp < 0 ? 0 : amp + 0.3 + drums_amp
        sleep sleep
      end
    end

    sub = arr[0..i]
    sl = sub.length * sleep > 2 ? 4.0 - (sub.length * sleep) : 2.0 - (sub.length * sleep)

    sub.each { |n|
      n === key ? (inserted = true; use_synth synths[:opt1]) : (inserted = false; use_synth synths[:opt2])

      if inserted
        play n, amp: silence ? 0 : shutup_synths ? 0 : amp / 2.0 + synths_amp < 0 ? 0 : amp / 2.0 + synths_amp, cutoff: 70, release: 0.3

        if note_swapped
          play note_swapped, cutoff: 60, release: 0.3, amp: silence ? 0 : shutup_synths ? 0 : amp / 2.0 + synths_amp < 0 ? 0 : amp / 2.0 + synths_amp
        end

      else
        play n, release: 0.3, amp: silence ? 0 : shutup_synths ? 0 : amp + (amp / 2.0) + synths_amp < 0 ? 0 : amp + (amp / 2.0) + synths_amp
      end

      sleep sleep
    }
    sleep sl
  end

  if not silence
    sorted.call(arr, "Insertion Sort")
  end
end


# MERGE SORT FUNCTIONS
def play_list(list:, amp:, pan: 0, sleep:, percs:, percs_amp:, synths_amp:, shutup_synths:, shutup_percs:, silence:)

  if list.length < 1
    sample percs[:opt3], pan: pan, amp: silence ? 0 : shutup_percs ? 0 : amp + (amp / 2.0) + percs_amp < 0 ? 0 : amp + (amp / 2.0) + percs_amp, rate: [1, 2, -1].choose
  else
    list.each do |n|
      play n, pan: pan, amp: silence ? 0 : shutup_synths ? 0 : amp + synths_amp < 0 ? 0 : amp + synths_amp, release: 0.05, sustain: 0.1, decay: 0.05
      sleep sleep
    end
  end
end


def merge(left:, right:, run_sorted:, sorted:, amp:, sleep:, synths:, percs:,
          percs_amp:, synths_amp:, shutup_synths:, shutup_percs:, silence:)

  sample percs[:opt3], amp: silence ? 0 : shutup_percs ? 0 : 1 + percs_amp < 0 ? 0 : 1 + percs_amp

  use_synth synths[:opt]

  in_thread do
    play_list(list: left, amp: (amp / 2.0) + (amp / 4.0), pan: -1, sleep: sleep,
              percs: percs, percs_amp: percs_amp, synths_amp: synths_amp,
              shutup_synths: shutup_synths, shutup_percs: shutup_percs, silence: silence)
  end

  play_list(list: right, amp: (amp / 2.0) + (amp / 4.0), pan: 1, sleep: sleep,
            percs: percs, percs_amp: percs_amp, synths_amp: synths_amp,
            shutup_synths: shutup_synths, shutup_percs: shutup_percs, silence: silence)

  sorted_list = []
  while !left.empty? && !right.empty?
    if left.first < right.first
      sorted_list.push(left.shift)
    else
      sorted_list.push(right.shift)
    end

    in_thread do
      play_list(list: left, amp: amp / 2.0, pan: -1, sleep: sleep, percs: percs, shutup_synths: shutup_synths,
                shutup_percs: shutup_percs, percs_amp: percs_amp, synths_amp: synths_amp,
                silence: silence)
    end

    play_list(list: right, amp: amp / 2.0, pan: 1, sleep: sleep,
              percs: percs, percs_amp: percs_amp, synths_amp: synths_amp,
              shutup_synths: shutup_synths, shutup_percs: shutup_percs, silence: silence)
  end

  play_list(list: left, amp: amp, pan: -1, sleep: sleep, percs: percs, percs_amp: percs_amp,
            synths_amp: synths_amp, shutup_synths: shutup_synths, shutup_percs: shutup_percs,
            silence: silence)

  play_list(list: right, amp: amp, pan: 1, sleep: sleep, percs: percs, percs_amp: percs_amp,
            synths_amp: synths_amp, shutup_synths: shutup_synths, shutup_percs: shutup_percs,
            silence: silence)

  play_list(list: sorted_list.concat(right).concat(left), amp: amp, sleep: sleep, percs: percs,
            percs_amp: percs_amp, synths_amp: synths_amp, shutup_synths: shutup_synths,
            shutup_percs: shutup_percs, silence: silence)

  if run_sorted and sorted_list.length > 3
    sorted.call(sorted_list, "Merge")
  end

  sorted_list
end

def merge_sort(list: DEFAULT_LIST_MERGE, side: nil, sorted: DEFAULT_SORTED, run_sorted: true, amp: 1, sleep: 0.25,
               synths: {:main => :square, :opt => :beep}, shutup_synths: false, shutup_percs: false, silence: false,
               percs: {:opt1 => :elec_flip, :opt2 => :elec_plip, :opt3 => :ambi_swoosh}, percs_amp: 0, synths_amp: 0)

  sample percs[:opt1], amp: silence ? 0 : shutup_percs ? 0 : amp + 0.5 + percs_amp < 0 ? 0 : amp + 0.5 + percs_amp

  use_synth synths[:main]

  p = (side == "left") ? -1 : (side == "right") ?  1 : 0
  play_list(list: list, amp: amp, pan: p, sleep: sleep, percs: percs, shutup_synths: shutup_synths,
            shutup_percs: shutup_percs, percs_amp: percs_amp, synths_amp: synths_amp, silence: silence)

  if list.length <= 1
    sample percs[:opt2], amp: silence ? 0 : shutup_percs ? 0 : amp + (amp / 2.0) + percs_amp < 0 ? 0 : amp + (amp / 2.0) + percs_amp
    sleep sleep * 2
    return list
  end

  mid = list.length / 2
  left = merge_sort(list: list.slice(0...mid), side: "left", sorted: sorted, run_sorted: run_sorted,
                    amp: amp, sleep: sleep, synths: synths, percs: percs, percs_amp: percs_amp, synths_amp: synths_amp,
                    shutup_synths: shutup_synths, shutup_percs: shutup_percs, silence: silence)

  right = merge_sort(list: list.slice(mid..list.length), side: "right", sorted: sorted, run_sorted: run_sorted,
                     sleep: sleep, amp: amp, synths: synths, percs: percs, percs_amp: percs_amp, synths_amp: synths_amp,
                     shutup_synths: shutup_synths, shutup_percs: shutup_percs, silence: silence)

  merge(left: left, right: right, sorted: sorted, run_sorted: run_sorted, amp: amp,
        sleep: sleep, synths: synths, percs: percs, percs_amp: percs_amp, synths_amp: synths_amp,
        shutup_synths: shutup_synths, shutup_percs: shutup_percs, silence: silence)
end

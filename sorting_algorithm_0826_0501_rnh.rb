# 代码生成时间: 2025-08-26 05:01:59
# sorting_algorithm.rb
# This Ruby script provides a simple sorting algorithm implementation.

# Sorting class that encapsulates sorting logic.
class Sorting
  # Bubble Sort implementation.
  #
  # @param [Array] arr The array to be sorted.
  # @return [Array] The sorted array.
  def bubble_sort(arr)
    raise ArgumentError, 'Input must be an Array' unless arr.is_a?(Array)
    n = arr.length
    loop do
      swapped = false
      (n-1).times do |i|
        if arr[i] > arr[i+1]
          arr[i], arr[i+1] = arr[i+1], arr[i] # Swap elements
          swapped = true
        end
      end
      break unless swapped # If no swap occurred, the array is sorted.
    end
    arr
  end
end

# Main program execution.
if __FILE__ == $0
  # Create an instance of the Sorting class.
  sorter = Sorting.new

  # Example unsorted array.
  unsorted_array = [32, 5, 1, 4, 2]

  # Sort the array using the bubble_sort method.
  sorted_array = sorter.bubble_sort(unsorted_array)

  # Output the sorted array.
  puts "Sorted array: #{sorted_array}"
end
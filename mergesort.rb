 require 'byebug'
 # Split array into 2 recursively (left and right)
 # An array of 1 element is considered sorted
 # Compare left and right nodes and sort until new array is given

 def merge_sort(arr)
  return arr if arr.length <= 1

  array_a = merge_sort(arr[0..arr.length / 2 - 1 ])
  array_b = merge_sort(arr[arr.length/2..-1])
  new_array = []
  
  until array_a.empty? || array_b.empty?
    new_array << if array_a[0] <= array_b[0]
      array_a.shift
    else
      array_b.shift
    end
  end
  new_array.concat(array_a, array_b)

 end  

 test_array = []

 100.times do
  test_array << rand(100)
 end


 p merge_sort([2,1])
 p merge_sort(test_array)

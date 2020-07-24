def bubble_sort(list)
  list.length.times do
    list.each_with_index do |e,i|
      unless list[i+1] == nil
        if e > list[i+1]
          list[i], list[i+1] = list[i+1], list[i]    
        end
      end
    end
  end
  list
end

p bubble_sort([4,3,78,2,0,2])
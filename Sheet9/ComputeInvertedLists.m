function [invertedLists] = ComputeInvertedLists(constellationMap)
    invertedLists = {};
    for i=1:size(constellationMap, 1)
        invertedLists{i} = find(constellationMap(i,:));
    end
end


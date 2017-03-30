function matchCount = getMatchCounts( features, imageCount )
X = cell2mat(features)';
Mdl = KDTreeSearcher(X);
idxNN = knnsearch(Mdl,X,'K',4);

[m,n] = size(idxNN);

matchCount = zeros(imageCount,imageCount);
ii = 0;
jj = 0;
for i=1:m
    prevLim = 0;
    for k=1:imageCount
        curLim = prevLim + size(features{k},2);
        if(i>prevLim && i<=curLim)
            ii = k;
            break;
        end
        prevLim = curLim;
    end
    for j=1:n
        idx = idxNN(i,j);
         prevLim = 0;
        for k=1:imageCount
            curLim = prevLim + size(features{k},2);
            if(idx>prevLim && idx<=curLim)
                jj = k;
                if(ii~=jj)
                    matchCount(ii,jj) = matchCount(ii,jj) + 1;
                end
                break;
            end
            prevLim = curLim;
        end
    end
end

end


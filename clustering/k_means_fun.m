function [ y,c ] = k_means_fun( X,num_clusters)
[m,n] = size(X);
c = better_initial_centroids(X,n,num_clusters);

e = 1;
while e > 0.0001
    [clust] = make_clusters(X,m,c,num_clusters);
    y = nansum(clust.*[1:1:num_clusters],2);
    c_old = c;
    c = update_centroids(X,m,n,clust,num_clusters);
    e = max(euclidean_distance(c_old,c));
end

end


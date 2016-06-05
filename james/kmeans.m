% TODO: change this to read the image we want it to read
img = 'img.jpg'

% Read in image as a "three dimensional matrix"
A = double(imread(img));
imshow(uint8(round(A)));

% Run Kmeans. Tweak the "num_clusters" parameter
img = double(imread('mandrill-small.tiff'));
min_iters = 50; % define distortion fn for convergence later
num_clusters = 16;
depth = size(img,3); % should be three-dimensional for the (R,G,B) vector
length = size(img,1);

% generate the centroids randomly
centroids = zeros(num_clusters, depth); % access centroids(centroid, r/g/b)
for j = 1:num_clusters
    x_rand = randi([1,length],1,1);
    y_rand = randi([1,length],1,1);
    centroids(j,1) = img(x_rand, y_rand, 1); % R value of rand pixel
    centroids(j,2) = img(x_rand, y_rand, 2); % G value of rand pixel
    centroids(j,3) = img(x_rand, y_rand, 3); % B value of rand pixel
end

% cluster assignments for each pixel, maps (x,y) --> cluster index
assignments = zeros(length, length);

% run k-means
for t = 1:min_iters
    
    % assign every pixel to a centroid cluster
    for l = 1:length
        for w = 1:length
            pixel = [img(l,w,1) img(l,w,2) img(l,w,3)];
            best_cluster_idx = 0;
            min_distance = Inf;
            for j = 1:num_clusters
                centroid = [centroids(j,1) centroids(j,2) centroids(j,3)];
                distance = norm(pixel - centroid);
                if distance < min_distance
                    min_distance = distance;
                    best_cluster_idx = j;
                end
            end
            assignments(l,w) = best_cluster_idx;
        end
    end

    % move each cluster centroid to the mean of the pts assigned to it
    % create auxiliary data structures to allow one pass over all pixels
    num_in_each_cluster = zeros(16);
    pixel_avgs = zeros(num_clusters, depth);
    for l = 1:length
        for w = 1:length
            pixel = [img(l,w,1) img(l,w,2) img(l,w,3)];
            a = assignments(l,w);
            num_in_each_cluster(a) = num_in_each_cluster(a) + 1;
            pixel_avgs(a,1) = pixel_avgs(a,1) + pixel(1);
            pixel_avgs(a,2) = pixel_avgs(a,2) + pixel(2);
            pixel_avgs(a,3) = pixel_avgs(a,3) + pixel(3);
        end
    end
    for j = 1:num_clusters
        centroids(j,1) = round(pixel_avgs(j,1) ./ num_in_each_cluster(j));
        centroids(j,2) = round(pixel_avgs(j,2) ./ num_in_each_cluster(j));
        centroids(j,3) = round(pixel_avgs(j,3) ./ num_in_each_cluster(j));
    end
end


% Replace pixels in large image with (r,g,b) of closest centroid and
% display the new image.
large_length = size(A, 1);
new_img = zeros(large_length, large_length, depth);
for l = 1:large_length
    for w = 1:large_length
        pixel = [A(l,w,1) A(l,w,2) A(l,w,3)];
        closest_centroid_idx = 0;
        min_distance = Inf;
        for j = 1:num_clusters
            centroid = [centroids(j,1) centroids(j,2) centroids(j,3)];
            distance = norm(pixel - centroid);
            if distance < min_distance
                min_distance = distance;
                closest_centroid_idx = j;
            end            
        end
        new_img(l,w,1) = centroids(closest_centroid_idx,1);
        new_img(l,w,2) = centroids(closest_centroid_idx,2);
        new_img(l,w,3) = centroids(closest_centroid_idx,3);
    end
end

% Show the reduced color image
imshow(uint8(round(new_img)));
function mask = create_random_mask(batch_images_size, local_area_size, mask_range)
    images_h = batch_images_size(1);
    images_w = batch_images_size(2);
    
    local_area_h = local_area_size(1);
    local_area_w = local_area_size(2);
    
    if images_h < local_area_h || images_w < local_area_w
        error('images size should not smaller than local size');
    end
    if mask_range(1) > mask_range(2)
        error('wrong mask range');
    end
    if mask_range(2) > local_area_h || mask_range(2) > local_area_w
        error('max mask size should not bigger than local area size');
    end
    
    local_area_h_start = randi( [1, images_h-local_area_h+1], 1, 1);
    local_area_w_start = randi( [1, images_w-local_area_w+1], 1, 1);
    
    mask_size = randi(mask_range, 1, 2);
    mask_h = mask_size(1);
    mask_w = mask_size(2);
    
    mask_h_start = randi( [1, local_area_h-mask_h+1], 1, 1) + local_area_h_start-1;
    mask_w_start = randi( [1, local_area_w-mask_w+1], 1, 1) + local_area_w_start-1;
    
    mask_array = zeros(batch_images_size);
    mask_array(mask_h_start:mask_h_start+mask_h-1, mask_w_start:mask_w_start+mask_w-1, :, :) = 1;
    
    mask.local_area_size = local_area_size;
    mask.local_area_left_top_point = [local_area_h_start, local_area_w_start];
    mask.mask_array = mask_array;
end
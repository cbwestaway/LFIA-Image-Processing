function [homography_matrix] = get_homography_matrix(i)
    switch i
        case 1
            homography_matrix = num2cell([
                2298 2387 3037 3106;
                2351 2432 3076 3151;
                2509 2590 3245 3319;
            ]);
        case 2
            homography_matrix = num2cell([
                2544 2625 3288 3346;
                2424 2513 3168 3231;
            ]);
        case 3
            homography_matrix = num2cell([
                2512 2582 3247 3311;
                2261 2336 3014 3073;
            ]);
    end
end

% Pixel
% function [homography_matrix] = get_homography_matrix(i)
%     switch i
%         case 1
%             homography_matrix = num2cell([
%                 2379 2469 3152 3236;
%                 2305 2396 3091 3175;
%                 2405 2496 3186 3272;
%             ]);
%         case 2
%             homography_matrix = num2cell([
%                 2471 2560 3249 3329;
%                 2831 2923 3609 3680;
%             ]);
%         case 3
%             homography_matrix = num2cell([
%                 2385 2476 3172 3241;
%                 2259 2350 3049 3138;
%             ]);
%     end
% end
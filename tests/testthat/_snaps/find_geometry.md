# finding geometry works

    Code
      find_geometry("Christmas Island, Australia")
    Message <simpleMessage>
      Passing 1 address to the Nominatim single address geocoder
      Query completed in: 1 seconds
    Output
      Simple feature collection with 1 feature and 1 field
      Geometry type: POLYGON
      Dimension:     XY
      Bounding box:  xmin: 11657270 ymin: -1274461 xmax: 11857270 ymax: -1074461
      Projected CRS: WGS 84 / Pseudo-Mercator
      # A tibble: 1 x 2
        address                                                               geometry
      * <chr>                                                            <POLYGON [m]>
      1 Christmas Island, Australia ((11857270 -1174461, 11857133 -1179695, 11856722 ~


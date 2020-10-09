/// @description ds_grid_rotate(Grid id, Clockwise, Rotation)
/// @param Grid id
/// @param  Clockwise
/// @param  Rotation
function ds_grid_rotate(argument0, argument1, argument2) {
	//Rotate the value on a grid Clockwise or Counterclockwise
	//Set Clockwise to true. If false it's Counterclockwise.
	//Rotation: Number of rotations: 1-2-3 (You can crank that number if you want, it will be 'moded'.)

	/*
	Examples:
	CW, 1 rotation:
	012
	345
	678
	becomes:
	630
	741
	852

	CCW, 1 rotation:
	0123
	4567
	becomes:
	40
	51
	62
	73

	CW, 2 rotation:
	012
	345
	becomes:
	543
	210
	*/

	var grid = argument0;
	var clockwise = argument1;
	var nmb_rot = argument2;

	nmb_rot = nmb_rot mod 4; //To prevent a stack overflow error.

	if nmb_rot == 0
	{
	exit;
	}

	var gw = ds_grid_width(grid);
	var gh = ds_grid_height(grid);

	var tmp_grid = ds_grid_create(gh,gw);
	var xx, yy, txx, tyy;

	if (clockwise)
	{
	txx = gh-1;
	tyy = 0;

	    for(yy=0; yy<gh; yy++)
	    {
	        for (xx=0; xx<gw; xx++)
	        {
	        ds_grid_set(tmp_grid, txx, tyy, ds_grid_get(grid, xx, yy));
	        tyy++;
	        }
        
	    tyy=0;  
	    txx--;
	    }
	}
	else
	{
	txx = 0;
	tyy = gw-1;

	    for(yy=0; yy<gh; yy++)
	    {
	        for (xx=0; xx<gw; xx++)
	        {
	        ds_grid_set(tmp_grid, txx, tyy, ds_grid_get(grid, xx, yy));
	        tyy--;
	        }
        
	    tyy=gw-1;  
	    txx++;
	    }
	}

	ds_grid_copy(grid, tmp_grid);
	ds_grid_destroy(tmp_grid);


	nmb_rot--;

	if (nmb_rot > 0)
	{
	ds_grid_rotate(clockwise, grid, nmb_rot); //This is where a stack over flow could occurs. ie: Asking to rotate 1000 times. But we've mod nmb_rot so it won't happen.
	}

}
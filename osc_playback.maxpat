{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 8,
			"minor" : 1,
			"revision" : 11,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"classnamespace" : "box",
		"rect" : [ -442.0, -1044.0, 1675.0, 757.0 ],
		"bglocked" : 0,
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 1,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 1,
		"objectsnaponopen" : 1,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
		"lefttoolbarpinned" : 0,
		"toptoolbarpinned" : 0,
		"righttoolbarpinned" : 0,
		"bottomtoolbarpinned" : 0,
		"toolbars_unpinned_last_save" : 0,
		"tallnewobj" : 0,
		"boxanimatetime" : 200,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"description" : "",
		"digest" : "",
		"tags" : "",
		"style" : "",
		"subpatcher_template" : "",
		"assistshowspatchername" : 0,
		"boxes" : [ 			{
				"box" : 				{
					"code" : "\r\n%Matlab side OSC code\r\n\r\n\r\n% OSC to Max/msp Start the experiment\r\n\r\nHr = dsp.UDPReceiver('LocalIPPort',7401); % read osc data from another device\r\ndR =[]; %\r\nout = 0; %\r\nviewer = HelperOrientationViewer; % view sensor orientation\r\n\r\nwhile out==0\r\n    [accel,gyro,mag] = readSensorDataMPU9250(imu); %read real time data\r\n    \r\n    mag_ave = mean(mag);\r\n    mag_calibrated = (mag_ave - b) *A;\r\n    %mag_unit = mag_ave ./ norm(mag_ave);\r\n    mag_unit = mag_calibrated  ./ norm(mag_calibrated);\r\n    acc_ave = mean(accel);\r\n    accel_unit = acc_ave ./ norm(acc_ave);\r\n    \r\n    D= -accel_unit;\r\n    E = cross(D, mag_unit);\r\n    E = E ./ norm(E);\r\n    N = cross(E,D);\r\n    N = N ./ norm(N);\r\n    \r\n    C = [N' , E', D']; % build the DCM\r\n    Q = quaternion(dcm2quat(C)); % get the quaternion\r\n    viewer(Q); % update the viewer\r\n    Degree = eulerd(Q,'xyz','point'); % calculate to eulerd angle\r\n    pause( .1);\r\n    \r\n    dR = step(Hr); % reciever\r\n    \r\n    if isempty(dR)==0\r\n        disp('run')\r\n        disp('gpt data')\r\n        [tag,data]= oscread(dR); % data comesfrom Max\r\n        data = cell2mat(data);\r\n        \r\n        if  data==11111  % if the data is 11111 max sapce press\r\n            %read sensor data and convert to euler angle\r\n            \r\n            [accel,gyro,mag] = readSensorDataMPU9250(imu);\r\n            \r\n            mag_ave = mean(mag);\r\n            mag_calibrated = (mag_ave - b) *A;\r\n            %mag_unit = mag_ave ./ norm(mag_ave);\r\n            mag_unit = mag_calibrated  ./ norm(mag_calibrated);\r\n            acc_ave = mean(accel);\r\n            accel_unit = acc_ave ./ norm(acc_ave);\r\n            \r\n            D= -accel_unit;\r\n            E = cross(D, mag_unit);\r\n            E = E ./ norm(E);\r\n            N = cross(E,D);\r\n            N = N ./ norm(N);\r\n            \r\n            C = [N' , E', D']; % build the DCM\r\n            Q = quaternion(dcm2quat(C));\r\n            viewer(Q); % update the viewer\r\n            Degree = eulerd(Q,'xyz','point');\r\n            disp(Degree)\r\n            \r\n            % sent data to another device(max)\r\n            Hs=dsp.UDPSender('RemoteIPAddress','127.0.0.1','RemoteIPPort',7400);\r\n            test1= oscwrite('/x',{Degree(1)});\r\n            test2= oscwrite('/y',{Degree(2)});\r\n            test3= oscwrite('/z',{Degree(3)});\r\n            %test1= oscwrite('/x',{magReadings(1)});\r\n            step(Hs,test1);\r\n            step(Hs,test2);\r\n            step(Hs,test3);\r\n            \r\n        elseif data==33333    % trial over\r\n            break\r\n        else                 % error\r\n            error('error');\r\n        end\r\n    end\r\nend\r\n\r\ndisp('end')\r\n%disp([tag data]);\r\nrelease(Hr);\r\nrelease (imu);\r\ndelete(imu)\r\n\r\n",
					"fontface" : 0,
					"fontname" : "<Monospaced>",
					"fontsize" : 12.0,
					"id" : "obj-7",
					"maxclass" : "codebox",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 761.0, 94.0, 673.0, 511.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-27",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 232.25, 279.0, 29.5, 22.0 ],
					"text" : "0"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-25",
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 167.5, 690.0, 45.0, 45.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-24",
					"lastchannelcount" : 0,
					"maxclass" : "live.gain~",
					"numinlets" : 2,
					"numoutlets" : 5,
					"outlettype" : [ "signal", "signal", "", "float", "list" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 175.25, 525.0, 48.0, 136.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_longname" : "live.gain~",
							"parameter_mmax" : 6.0,
							"parameter_mmin" : -70.0,
							"parameter_shortname" : "live.gain~",
							"parameter_type" : 0,
							"parameter_unitstyle" : 4
						}

					}
,
					"varname" : "live.gain~"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-23",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 175.25, 279.0, 29.5, 22.0 ],
					"text" : "1"
				}

			}
, 			{
				"box" : 				{
					"basictuning" : 440,
					"clipheight" : 78.0,
					"data" : 					{
						"clips" : [ 							{
								"absolutepath" : "/Users/ankourosen/Downloads/research_for_2022/16chconv_new_demo/Anechoic audio samples/Clarinet.wav",
								"filename" : "Clarinet.wav",
								"filekind" : "audiofile",
								"id" : "u633004828",
								"loop" : 0,
								"content_state" : 								{

								}

							}
, 							{
								"absolutepath" : "/Users/ankourosen/Downloads/research_for_2022/16chconv_new_demo/Anechoic audio samples/drum kit.wav",
								"filename" : "drum kit.wav",
								"filekind" : "audiofile",
								"id" : "u046004827",
								"loop" : 0,
								"content_state" : 								{

								}

							}
 ]
					}
,
					"followglobaltempo" : 0,
					"formantcorrection" : 0,
					"id" : "obj-21",
					"maxclass" : "playlist~",
					"mode" : "basic",
					"numinlets" : 1,
					"numoutlets" : 5,
					"originallength" : [ 0.0, "ticks" ],
					"originaltempo" : 120.0,
					"outlettype" : [ "signal", "signal", "signal", "", "dictionary" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 183.25, 334.0, 501.0, 158.0 ],
					"pitchcorrection" : 0,
					"quality" : "basic",
					"timestretch" : [ 0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-12",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 232.25, 234.0, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-8",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 175.25, 234.0, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-9",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "int", "" ],
					"patching_rect" : [ 501.0, 138.0, 79.0, 22.0 ],
					"text" : "serial a 9600"
				}

			}
, 			{
				"box" : 				{
					"comment" : "",
					"id" : "obj-2",
					"index" : 0,
					"maxclass" : "inlet",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 306.0, 9.0, 30.0, 30.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-18",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 301.0, 83.0, 66.0, 22.0 ],
					"text" : "/test 11111"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-10",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 3,
					"outlettype" : [ "", "", "" ],
					"patching_rect" : [ 175.25, 186.0, 133.0, 22.0 ],
					"text" : "route /x /y"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-6",
					"maxclass" : "button",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 306.0, 49.0, 24.0, 24.0 ]
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-4",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 489.0, 186.0, 137.0, 22.0 ],
					"text" : "udpsend localhost 7401"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-1",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 175.25, 142.0, 99.0, 22.0 ],
					"text" : "udpreceive 7400"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-10", 0 ],
					"source" : [ "obj-1", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-12", 0 ],
					"source" : [ "obj-10", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-8", 0 ],
					"source" : [ "obj-10", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-27", 0 ],
					"source" : [ "obj-12", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 0 ],
					"source" : [ "obj-2", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-24", 1 ],
					"source" : [ "obj-21", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-24", 0 ],
					"source" : [ "obj-21", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-21", 0 ],
					"source" : [ "obj-23", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-25", 1 ],
					"source" : [ "obj-24", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-25", 0 ],
					"source" : [ "obj-24", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-21", 0 ],
					"source" : [ "obj-27", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-18", 0 ],
					"source" : [ "obj-6", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-23", 0 ],
					"source" : [ "obj-8", 0 ]
				}

			}
 ],
		"parameters" : 		{
			"obj-24" : [ "live.gain~", "live.gain~", 0 ],
			"parameterbanks" : 			{

			}
,
			"inherited_shortname" : 1
		}
,
		"dependency_cache" : [ 			{
				"name" : "Clarinet.wav",
				"bootpath" : "~/Downloads/research_for_2022/16chconv_new_demo/Anechoic audio samples",
				"patcherrelativepath" : "./Anechoic audio samples",
				"type" : "WAVE",
				"implicit" : 1
			}
, 			{
				"name" : "drum kit.wav",
				"bootpath" : "~/Downloads/research_for_2022/16chconv_new_demo/Anechoic audio samples",
				"patcherrelativepath" : "./Anechoic audio samples",
				"type" : "WAVE",
				"implicit" : 1
			}
 ],
		"autosave" : 0
	}

}

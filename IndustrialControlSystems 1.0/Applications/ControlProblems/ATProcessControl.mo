within IndustrialControlSystems.Applications.ControlProblems;
model ATProcessControl "PI control of typical processes, with automatic tuning"
  extends Modelica.Icons.Example;

  IndustrialControlSystems.Applications.TrasferFunctions.TypicalTF NoControl(delay_FOD=
       1, delay_iD=1)
    annotation (Placement(transformation(extent={{0,132},{40,212}})));
  Modelica.Blocks.Sources.TimeTable
                               step(table=[0,0; 0,0.6; 400,0.6; 400,1; 600,1])
    annotation (Placement(transformation(extent={{-100,190},{-80,210}})));
  IndustrialControlSystems.Applications.TrasferFunctions.TypicalTF Controlled(delay_FOD=
       1, delay_iD=1)
    annotation (Placement(transformation(extent={{60,44},{100,124}})));
  Controllers.AutoTuning.ATPIrelayNCmixedMode
                R_FO(
    Ts=0.1,
    CSmin=0,
    CSmax=5,
    permOxPeriodPerc=5,
    pm=65,
    nOxMin=3,
    AntiWindup=true)
    annotation (Placement(transformation(extent={{-64,104},{-44,124}})));
  Controllers.AutoTuning.ATPIrelayNCmixedMode
                R_FOD(
    Ts=0.1,
    CSmin=0,
    CSmax=5,
    Kp=1,
    Ti=4,
    permOxPeriodPerc=5,
    pm=65,
    nOxMin=3,
    slope=0.1,
    AntiWindup=true)
    annotation (Placement(transformation(extent={{-64,74},{-44,94}})));
  Controllers.AutoTuning.ATPIrelayNCmixedMode
                R_i(
    Ts=0.1,
    CSmax=5,
    permOxPeriodPerc=5,
    nOxMin=3,
    AntiWindup=true,
    CSmin=-5,
    pm=65)
    annotation (Placement(transformation(extent={{-64,42},{-44,62}})));
  Controllers.AutoTuning.ATPIrelayNCmixedMode
                R_iD(
    Ts=0.1,
    CSmax=5,
    Kp=5,
    Ti=30,
    slope=0.01,
    CSmin=-5,
    nOxMin=3,
    permOxPeriodPerc=30,
    pm=70,
    AntiWindup=true)
    annotation (Placement(transformation(extent={{-64,10},{-44,30}})));
  Controllers.AutoTuning.ATPIrelayNCmixedMode
                R_OS(
    Ts=0.1,
    CSmin=0,
    CSmax=5,
    permOxPeriodPerc=5,
    pm=65,
    nOxMin=3,
    AntiWindup=true)
    annotation (Placement(transformation(extent={{-64,-22},{-44,-2}})));
  Controllers.AutoTuning.ATPIrelayNCmixedMode
                R_US(
    Ts=0.1,
    CSmin=0,
    CSmax=5,
    slope=0.05,
    pm=45,
    Ti=1,
    Kp=0.1,
    permOxPeriodPerc=5,
    nOxMin=3,
    AntiWindup=true)
    annotation (Placement(transformation(extent={{-64,-52},{-44,-32}})));
  Controllers.AutoTuning.ATPIrelayNCmixedMode
                R_Osc(
    Ts=0.1,
    CSmin=0,
    CSmax=5,
    Ti=5,
    Kp=1,
    permOxPeriodPerc=5,
    pm=65,
    nOxMin=3,
    slope=0.1,
    AntiWindup=true)
    annotation (Placement(transformation(extent={{-64,-82},{-44,-62}})));
  Controllers.AutoTuning.ATPIrelayNCmixedMode
                R_FS(
    Ts=0.1,
    CSmin=0,
    CSmax=5,
    permOxPeriodPerc=5,
    pm=65,
    nOxMin=3,
    AntiWindup=true)
    annotation (Placement(transformation(extent={{-64,-118},{-44,-98}})));
  Modelica.Blocks.Sources.BooleanTable      ATpulse(table={120,120.1})
                          annotation (Placement(transformation(extent={{-98,140},
            {-80,158}},rotation=0)));
equation
  connect(step.y, NoControl.FO_u) annotation (Line(
      points={{-79,200},{-48,200},{-48,210.261},{2,210.261}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, NoControl.FOD_u) annotation (Line(
      points={{-79,200},{-46.5,200},{-46.5,199.826},{2,199.826}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, NoControl.i_u) annotation (Line(
      points={{-79,200},{-48,200},{-48,189.391},{2,189.391}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, NoControl.iD_u) annotation (Line(
      points={{-79,200},{-48,200},{-48,178.957},{2,178.957}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, NoControl.OS_u) annotation (Line(
      points={{-79,200},{-48,200},{-48,168.522},{2,168.522}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, NoControl.Osc_u) annotation (Line(
      points={{-79,200},{-48,200},{-48,147.652},{2,147.652}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_FO.CS, Controlled.FO_u) annotation (Line(
      points={{-45,114},{-42,114},{-42,122.261},{62,122.261}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Controlled.FO_y, R_FO.PV) annotation (Line(
      points={{62,118.783},{-38,118.783},{-38,96},{-70,96},{-70,113},{-62,113}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, R_FO.SP) annotation (Line(
      points={{-79,200},{-72,200},{-72,120},{-62,120}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, R_FOD.SP) annotation (Line(
      points={{-79,200},{-72,200},{-72,90},{-62,90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_FOD.CS, Controlled.FOD_u) annotation (Line(
      points={{-45,84},{-34,84},{-34,111.826},{62,111.826}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Controlled.FOD_y, R_FOD.PV) annotation (Line(
      points={{62,108.348},{-30,108.348},{-30,66},{-70,66},{-70,83},{-62,83}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, R_i.SP) annotation (Line(
      points={{-79,200},{-72,200},{-72,58},{-62,58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_i.CS, Controlled.i_u) annotation (Line(
      points={{-45,52},{-24,52},{-24,101.391},{62,101.391}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Controlled.i_y, R_i.PV) annotation (Line(
      points={{62,97.913},{-20,97.913},{-20,34},{-70,34},{-70,51},{-62,51}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_iD.CS, Controlled.iD_u) annotation (Line(
      points={{-45,20},{-14,20},{-14,90.9565},{62,90.9565}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Controlled.iD_y, R_iD.PV) annotation (Line(
      points={{62,87.4783},{-10,87.4783},{-10,2},{-70,2},{-70,19},{-62,19}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, R_OS.SP) annotation (Line(
      points={{-79,200},{-72,200},{-72,-6},{-62,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_OS.CS, Controlled.OS_u) annotation (Line(
      points={{-45,-12},{-6,-12},{-6,80.5217},{62,80.5217}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Controlled.OS_y, R_OS.PV) annotation (Line(
      points={{62,77.0435},{0,77.0435},{0,-30},{-70,-30},{-70,-13},{-62,-13}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, R_Osc.SP) annotation (Line(
      points={{-79,200},{-72,200},{-72,-66},{-62,-66}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_Osc.CS, Controlled.Osc_u) annotation (Line(
      points={{-45,-72},{14,-72},{14,59.6522},{62,59.6522}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Controlled.Osc_y, R_Osc.PV) annotation (Line(
      points={{62,56.1739},{18,56.1739},{18,-90},{-70,-90},{-70,-73},{-62,-73}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, NoControl.FS_u) annotation (Line(
      points={{-79,200},{-48,200},{-48,137.217},{2,137.217}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, R_FS.SP) annotation (Line(
      points={{-79,200},{-72,200},{-72,-102},{-62,-102}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_FS.CS, Controlled.FS_u) annotation (Line(
      points={{-45,-108},{24,-108},{24,49.2174},{62,49.2174}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Controlled.FS_y, R_FS.PV) annotation (Line(
      points={{62,45.7391},{28,45.7391},{28,-126},{-70,-126},{-70,-109},{-62,-109}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(ATpulse.y, R_FO.ATreq) annotation (Line(
      points={{-79.1,149},{-76,149},{-76,106},{-62,106}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(ATpulse.y, R_FOD.ATreq) annotation (Line(
      points={{-79.1,149},{-76,149},{-76,76},{-62,76}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(ATpulse.y, R_i.ATreq) annotation (Line(
      points={{-79.1,149},{-76,149},{-76,44},{-62,44}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(ATpulse.y, R_OS.ATreq) annotation (Line(
      points={{-79.1,149},{-76,149},{-76,-20},{-62,-20}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(ATpulse.y, R_Osc.ATreq) annotation (Line(
      points={{-79.1,149},{-76,149},{-76,-80},{-62,-80}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(ATpulse.y, R_FS.ATreq) annotation (Line(
      points={{-79.1,149},{-76,149},{-76,-116},{-62,-116}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(step.y, NoControl.US_u) annotation (Line(
      points={{-79,200},{-48,200},{-48,158.087},{2,158.087}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_US.CS, Controlled.US_u) annotation (Line(
      points={{-45,-42},{4,-42},{4,70.087},{62,70.087}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Controlled.US_y, R_US.PV) annotation (Line(
      points={{62,66.6087},{36,66.6087},{36,66},{8,66},{8,-58},{-70,-58},{-70,
          -43},{-62,-43}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(ATpulse.y, R_iD.ATreq) annotation (Line(
      points={{-79.1,149},{-76,149},{-76,12},{-62,12}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(R_US.ATreq, ATpulse.y) annotation (Line(
      points={{-62,-50},{-76,-50},{-76,149},{-79.1,149}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(R_iD.SP, step.y) annotation (Line(
      points={{-62,26},{-72,26},{-72,200},{-79,200}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_US.SP, step.y) annotation (Line(
      points={{-62,-36},{-72,-36},{-72,200},{-79,200}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-140},
            {100,220}}), graphics), Icon(coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-140},{100,220}})),
    experiment(StopTime=500, NumberOfIntervals=5000),
    __Dymola_experimentSetupOutput(events=false),
    Documentation(revisions="<html>
<dl><dt>Industrial Control Systems (v 1.0.0) : April-May 2012</dt>
<dl><dt>List of revisions:</dt>
<p><ul>
<li>11 May 2012 (author: Marco Bonvini)</li>
</ul></p>
<dl><dt><b>Main Authors:</b> <br/></dt>
<dd>Marco Bonvini; &LT;<a href=\"mailto:bonvini@elet.polimi.it\">bonvini@elet.polimi.it</a>&GT;</dd>
<dd>Alberto Leva &LT;<a href=\"mailto:leva@elet.polimi.it\">leva@elet.polimi.it</a>&GT;<br/></dd>
<dd>Politecnico di Milano</dd>
<dd>Dipartimento di Elettronica e Informazione</dd>
<dd>Via Ponzio 34/5</dd>
<dd>20133 Milano - ITALIA -<br/></dd>
<dt><b>Copyright:</b> </dt>
<dd>Copyright &copy; 2010-2012, Marco Bonvini and Alberto Leva.<br/></dd>
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>.</i><br/></dd>
</dl></html>", info="
  <HTML>
  <h4>Description</h4>
  <p>
  In this examples the typical processes (contained in model
   <a href=\"modelica://IndustrialControlSystems.Applications.TrasferFunctions.TypicalTF\">TypicalTF</a> ) 
  are controlled with PI regulators with automatic tuning. The aim of this example is to show how the automatic
  tuning algorithm works with varius processes. For each trasfer function taken into account have been compared the 
  parameter values before and after the tuning. Also the algorith parameters are listed too. It is possible to see 
  that they have different values, depending on the considered example (e.g. the slope must be adapted in order to 
  avoid big oscillations, the percentual tolerance have to be adapted if the period of the oscillation changes,...).<br>
  The example is made of three phases:
  <ul>
  <li>Set point following with default parameters,</li>
  <li>Automatic tuning,</li>
  <li>Set point following with the tuned parameters.</li>
  </ul><br>
  
  <br/>Process Trasfer function </br>
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH colspan=2>Integrator</TH></TR>
  <tr>
  <td colspan =2>
  <pre>
  Y(s)     1
  ---- = -----
  U(s)     5s  </pre>
  </td>
  </tr>
  </table><br><br>
  Controller parameters
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Before</TH><TH>After AT</TH></TR>
  <tr><td>Kp</td><td>5</td><td>73.4625</td></tr>
  <tr><td>Ti</td><td>1</td><td>0.273</td></tr>
  </table><br><br>
  Automatic Tuning algorithm parameters
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Value</TH></TR>
  <tr><td>slope</td><td>1</td></tr>
  <tr><td>PermOxPeriodPerc</td><td>5</td></tr>
  <tr><td>pm</td><td>65</td></tr>
  <tr><td>nOxMin</td><td>3</td></tr>
  </table><br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/IntegratorControlledAT.png\"><br>
  
  <br/><br/>Process Trasfer function </br>
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH colspan=2>Integrator + delay</TH></TR>
  <tr>
  <td colspan =2>
  <pre>
  Y(s)     1     -1s
  ---- = ----- e
  U(s)     5s  </pre>
  </td>
  </tr>
  </table><br><br>
  Controller parameters
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Before</TH><TH>After AT</TH></TR>
  <tr><td>Kp</td><td>5</td><td>1.067</td></tr>
  <tr><td>Ti</td><td>30</td><td>26.54</td></tr>
  </table><br><br>
  Automatic Tuning algorithm parameters
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Value</TH></TR>
  <tr><td>slope</td><td>0.01</td></tr>
  <tr><td>PermOxPeriodPerc</td><td>30</td></tr>
  <tr><td>pm</td><td>70</td></tr>
  <tr><td>nOxMin</td><td>3</td></tr>
  </table><br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/IntegratorDelayControlledAT.png\"><br>
  
  <br/><br/>Process Trasfer function </br>
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH colspan=2>First Order</TH></TR>
  <tr>
  <td colspan =2>
  <pre>
  Y(s)      1   
  ---- = -------- 
  U(s)    1 + 5s  </pre>
  </td>
  </tr>
  </table><br><br>
  Controller parameters
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Before</TH><TH>After AT</TH></TR>
  <tr><td>Kp</td><td>5</td><td>71.5948</td></tr>
  <tr><td>Ti</td><td>1</td><td>0.1365</td></tr>
  </table><br><br>
  Automatic Tuning algorithm parameters
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Value</TH></TR>
  <tr><td>slope</td><td>1</td></tr>
  <tr><td>PermOxPeriodPerc</td><td>5</td></tr>
  <tr><td>pm</td><td>65</td></tr>
  <tr><td>nOxMin</td><td>3</td></tr>
  </table><br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/FirstOrderControlledAT.png\"><br>
  
  <br/><br/>Process Trasfer function </br>
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH colspan=2>First Order + delay</TH></TR>
  <tr>
  <td colspan =2>
  <pre>
  Y(s)      1      -2s
  ---- = -------- e
  U(s)    1 + 5s  </pre>
  </td>
  </tr>
  </table><br><br>
  Controller parameters
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Before</TH><TH>After AT</TH></TR>
  <tr><td>Kp</td><td>1</td><td>2.11</td></tr>
  <tr><td>Ti</td><td>4</td><td>5.1879</td></tr>
  </table><br><br>
  Automatic Tuning algorithm parameters
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Value</TH></TR>
  <tr><td>slope</td><td>0.1</td></tr>
  <tr><td>PermOxPeriodPerc</td><td>5</td></tr>
  <tr><td>pm</td><td>65</td></tr>
  <tr><td>nOxMin</td><td>3</td></tr>
  </table><br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/FirstOrderDelayControlledAT.png\"><br>
  
  <br/><br/>Process Trasfer function </br>
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH colspan=2>Fast Slow</TH></TR>
  <tr>
  <td colspan =2>
  <pre>
  Y(s)      1 + 5.8s  
  ---- = -------------- 
  U(s)    (1 + 6s)(1+s)  </pre>
  </td>
  </tr>
  </table><br><br>
  Controller parameters
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Before</TH><TH>After AT</TH></TR>
  <tr><td>Kp</td><td>5</td><td>14.056</td></tr>
  <tr><td>Ti</td><td>1</td><td>0.1365</td></tr>
  </table><br><br>
  Automatic Tuning algorithm parameters
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Value</TH></TR>
  <tr><td>slope</td><td>1</td></tr>
  <tr><td>PermOxPeriodPerc</td><td>5</td></tr>
  <tr><td>pm</td><td>65</td></tr>
  <tr><td>nOxMin</td><td>3</td></tr>
  </table><br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/FastSlowControlledAT.png\"><br>
  
  <br/><br/>Process Trasfer function </br>
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH colspan=2>Overshooting</TH></TR>
  <tr>
  <td colspan =2>
  <pre>
  Y(s)      1 + 8s  
  ---- = --------------- 
  U(s)    (1 + 5s)(1+2s)  </pre>
  </td>
  </tr>
  </table><br><br>
  Controller parameters
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Before</TH><TH>After AT</TH></TR>
  <tr><td>Kp</td><td>5</td><td>17.3146</td></tr>
  <tr><td>Ti</td><td>1</td><td>0.1365</td></tr>
  </table><br><br>
  Automatic Tuning algorithm parameters
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Value</TH></TR>
  <tr><td>slope</td><td>1</td></tr>
  <tr><td>PermOxPeriodPerc</td><td>5</td></tr>
  <tr><td>pm</td><td>65</td></tr>
  <tr><td>nOxMin</td><td>3</td></tr>
  </table><br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/OverShootingControlledAT.png\"><br>
  
  <br/><br/>Process Trasfer function </br>
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH colspan=2>Undershooting</TH></TR>
  <tr>
  <td colspan =2>
  <pre>
  Y(s)      1 - 5.5s  
  ---- = --------------- 
  U(s)    (1 + 5s)(1+2s)  </pre>
  </td>
  </tr>
  </table><br><br>
  Controller parameters
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Before</TH><TH>After AT</TH></TR>
  <tr><td>Kp</td><td>0.1</td><td>7.69</td></tr>
  <tr><td>Ti</td><td>1</td><td>0.692</td></tr>
  </table><br><br>
  Automatic Tuning algorithm parameters
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Value</TH></TR>
  <tr><td>slope</td><td>0.05</td></tr>
  <tr><td>PermOxPeriodPerc</td><td>5</td></tr>
  <tr><td>pm</td><td>45</td></tr>
  <tr><td>nOxMin</td><td>3</td></tr>
  </table><br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/UnderShootingControlledAT.png\"><br>
  
  <br/><br/>Process Trasfer function </br>
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH colspan=2>Complex Poles</TH></TR>
  <tr>
  <td colspan =2>
  <pre>
  Y(s)            1  
  ---- = -------------------- 
  U(s)    1 + 1.2 s + 0.025s  </pre>
  </td>
  </tr>
  </table><br><br>
  Controller parameters
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Before</TH><TH>After AT</TH></TR>
  <tr><td>Kp</td><td>1</td><td>0.548</td></tr>
  <tr><td>Ti</td><td>5</td><td>4.3</td></tr>
  </table><br><br>
  Automatic Tuning algorithm parameters
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Value</TH></TR>
  <tr><td>slope</td><td>0.1</td></tr>
  <tr><td>PermOxPeriodPerc</td><td>5</td></tr>
  <tr><td>pm</td><td>65</td></tr>
  <tr><td>nOxMin</td><td>3</td></tr>
  </table><br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/CompexPolesControlledAT.png\"><br>
  
  </p>
  
  </HTML>"));
end ATProcessControl;

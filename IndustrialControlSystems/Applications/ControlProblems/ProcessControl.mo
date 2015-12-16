within IndustrialControlSystems.Applications.ControlProblems;
model ProcessControl "PID control of typical processes"
  extends Modelica.Icons.Example;

  IndustrialControlSystems.Applications.TrasferFunctions.TypicalTF NoControl(delay_FOD=
       1, delay_iD=1)
    annotation (Placement(transformation(extent={{40,120},{100,220}})));
  Modelica.Blocks.Sources.Step step
    annotation (Placement(transformation(extent={{-100,190},{-80,210}})));
  IndustrialControlSystems.Applications.TrasferFunctions.TypicalTF Controlled(delay_FOD=
       1, delay_iD=1)
    annotation (Placement(transformation(extent={{38,8},{98,108}})));
  Controllers.PID
                R_FO(
    AntiWindup=true,
    CSmin=0,
    CSmax=5,
    Kp=10,
    Td=0.8,
    N=8,
    Ti=3)
    annotation (Placement(transformation(extent={{-64,104},{-44,124}})));
  Controllers.PID
                R_FOD(
    AntiWindup=true,
    CSmin=0,
    CSmax=5,
    Kp=1,
    Ti=4,
    Td=0.2,
    N=5)
    annotation (Placement(transformation(extent={{-64,74},{-44,94}})));
  Controllers.PID
                R_i(
    AntiWindup=true,
    CSmin=0,
    CSmax=5,
    Td=0.1,
    Kp=100,
    Ti=1)
    annotation (Placement(transformation(extent={{-64,42},{-44,62}})));
  Controllers.PID
                R_iD(
    CSmax=5,
    Td=0.1,
    Kp=5,
    N=8,
    Ti=30,
    AntiWindup=true,
    CSmin=-5)
    annotation (Placement(transformation(extent={{-64,10},{-44,30}})));
  Controllers.PID
                R_OS(
    AntiWindup=true,
    CSmin=0,
    CSmax=5,
    Ti=2,
    Kp=5)
    annotation (Placement(transformation(extent={{-64,-22},{-44,-2}})));
  Controllers.PID
                R_US(
    AntiWindup=true,
    CSmin=0,
    CSmax=5,
    N=5,
    Td=5,
    Kp=0.1,
    Ti=2)
    annotation (Placement(transformation(extent={{-64,-52},{-44,-32}})));
  Controllers.PID
                R_Osc(
    AntiWindup=true,
    CSmin=0,
    CSmax=5,
    Ti=2.5,
    Kp=10,
    Td=1)
    annotation (Placement(transformation(extent={{-64,-82},{-44,-62}})));
  Controllers.PID
                R_FS(
    AntiWindup=true,
    CSmin=0,
    CSmax=5,
    Td=0.2,
    Ti=0.8)
    annotation (Placement(transformation(extent={{-64,-118},{-44,-98}})));
equation
  connect(step.y, NoControl.FO_u) annotation (Line(
      points={{-79,200},{-48,200},{-48,217.826},{43,217.826}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, NoControl.FOD_u) annotation (Line(
      points={{-79,200},{-48.5,200},{-48.5,204.783},{43,204.783}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, NoControl.i_u) annotation (Line(
      points={{-79,200},{-48,200},{-48,191.739},{43,191.739}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, NoControl.iD_u) annotation (Line(
      points={{-79,200},{-48,200},{-48,178.696},{43,178.696}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, NoControl.OS_u) annotation (Line(
      points={{-79,200},{-48,200},{-48,165.652},{43,165.652}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, NoControl.Osc_u) annotation (Line(
      points={{-79,200},{-48,200},{-48,139.565},{43,139.565}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_FO.CS, Controlled.FO_u) annotation (Line(
      points={{-45,114},{2,114},{2,105.826},{41,105.826}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(Controlled.FO_y, R_FO.PV) annotation (Line(
      points={{41,101.478},{-38,101.478},{-38,96},{-70,96},{-70,113},{-62,113}},
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
      points={{-45,84},{-34,84},{-34,92.7826},{41,92.7826}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Controlled.FOD_y, R_FOD.PV) annotation (Line(
      points={{41,88.4348},{-30,88.4348},{-30,66},{-70,66},{-70,83},{-62,83}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, R_i.SP) annotation (Line(
      points={{-79,200},{-72,200},{-72,58},{-62,58}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_i.CS, Controlled.i_u) annotation (Line(
      points={{-45,52},{-24,52},{-24,79.7391},{41,79.7391}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Controlled.i_y, R_i.PV) annotation (Line(
      points={{41,75.3913},{-20,75.3913},{-20,34},{-70,34},{-70,51},{-62,51}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, R_iD.SP) annotation (Line(
      points={{-79,200},{-72,200},{-72,26},{-62,26}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_iD.CS, Controlled.iD_u) annotation (Line(
      points={{-45,20},{-14,20},{-14,66.6957},{41,66.6957}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Controlled.iD_y, R_iD.PV) annotation (Line(
      points={{41,62.3478},{-10,62.3478},{-10,2},{-70,2},{-70,19},{-62,19}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, R_OS.SP) annotation (Line(
      points={{-79,200},{-72,200},{-72,-6},{-62,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_OS.CS, Controlled.OS_u) annotation (Line(
      points={{-45,-12},{-6,-12},{-6,53.6522},{41,53.6522}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Controlled.OS_y, R_OS.PV) annotation (Line(
      points={{41,49.3043},{0,49.3043},{0,-30},{-70,-30},{-70,-13},{-62,-13}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, R_Osc.SP) annotation (Line(
      points={{-79,200},{-72,200},{-72,-66},{-62,-66}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_Osc.CS, Controlled.Osc_u) annotation (Line(
      points={{-45,-72},{14,-72},{14,27.5652},{41,27.5652}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Controlled.Osc_y, R_Osc.PV) annotation (Line(
      points={{41,23.2174},{18,23.2174},{18,-90},{-70,-90},{-70,-73},{-62,-73}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, NoControl.FS_u) annotation (Line(
      points={{-79,200},{-48,200},{-48,126.522},{43,126.522}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, R_FS.SP) annotation (Line(
      points={{-79,200},{-72,200},{-72,-102},{-62,-102}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_FS.CS, Controlled.FS_u) annotation (Line(
      points={{-45,-108},{24,-108},{24,14.5217},{41,14.5217}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Controlled.FS_y, R_FS.PV) annotation (Line(
      points={{41,10.1739},{28,10.1739},{28,-126},{-70,-126},{-70,-109},{-62,-109}},
      color={0,0,127},
      smooth=Smooth.None));

  connect(step.y, R_US.SP) annotation (Line(
      points={{-79,200},{-72,200},{-72,-36},{-62,-36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(R_US.CS, Controlled.US_u) annotation (Line(
      points={{-45,-42},{4,-42},{4,40.6087},{41,40.6087}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Controlled.US_y, R_US.PV) annotation (Line(
      points={{41,36.2609},{6,36.2609},{6,-58},{-70,-58},{-70,-43},{-62,-43}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(step.y, NoControl.US_u) annotation (Line(
      points={{-79,200},{-48,200},{-48,152.609},{43,152.609}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-140},
            {100,220}}), graphics), Icon(coordinateSystem(preserveAspectRatio=true,
          extent={{-100,-140},{100,220}})),
    experiment(StopTime=40),
    __Dymola_experimentSetupOutput,
    Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  In this examples the typical processes (contained in model
   <a href=\"modelica://IndustrialControlSystems.Applications.TrasferFunctions.TypicalTF\">TypicalTF</a> ) 
  are controlled with PID regulators.
  
  <br/><br/>Process Trasfer function </br>
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
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Value</TH></TR>
  <tr><td>Kp</td><td>100</td></tr>
  <tr><td>Ti</td><td>1</td></tr>
  <tr><td>Td</td><td>0.1</td></tr>
  <tr><td>N</td><td>10</td></tr>
  <tr><td>b</td><td>1</td></tr>
  <tr><td>c</td><td>1</td></tr>
  </table><br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/IntegratorControlled.png\"><br>
  
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
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Value</TH></TR>
  <tr><td>Kp</td><td>5</td></tr>
  <tr><td>Ti</td><td>30</td></tr>
  <tr><td>Td</td><td>0.1</td></tr>
  <tr><td>N</td><td>8</td></tr>
  <tr><td>b</td><td>1</td></tr>
  <tr><td>c</td><td>1</td></tr>
  </table><br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/IntegratorDelayControlled.png\"><br>
  
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
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Value</TH></TR>
  <tr><td>Kp</td><td>10</td></tr>
  <tr><td>Ti</td><td>3</td></tr>
  <tr><td>Td</td><td>0.8</td></tr>
  <tr><td>N</td><td>8</td></tr>
  <tr><td>b</td><td>1</td></tr>
  <tr><td>c</td><td>1</td></tr>
  </table><br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/FirstOrderControlled.png\"><br>
  
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
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Value</TH></TR>
  <tr><td>Kp</td><td>1</td></tr>
  <tr><td>Ti</td><td>4</td></tr>
  <tr><td>Td</td><td>0.2</td></tr>
  <tr><td>N</td><td>5</td></tr>
  <tr><td>b</td><td>1</td></tr>
  <tr><td>c</td><td>1</td></tr>
  </table><br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/FirstOrderDelayControlled.png\"><br>
  
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
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Value</TH></TR>
  <tr><td>Kp</td><td>5</td></tr>
  <tr><td>Ti</td><td>0.8</tr>
  <tr><td>Td</td><td>0.2</tr>
  <tr><td>N</td><td>10</tr>
  <tr><td>b</td><td>1</tr>
  <tr><td>c</td><td>1</tr>
  </table><br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/FastSlowControlled.png\"><br>
  
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
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Value</TH></TR>
  <tr><td>Kp</td><td>5</tr>
  <tr><td>Ti</td><td>2</td></tr>
  <tr><td>Td</td><td>1</td></tr>
  <tr><td>N</td><td>10</td></tr>
  <tr><td>b</td><td>1</td></tr>
  <tr><td>c</td><td>1</td></tr>
  </table><br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/OverShootingControlled.png\"><br>
  
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
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Value</TH></TR>
  <tr><td>Kp</td><td>0.1</td></tr>
  <tr><td>Ti</td><td>2</td></tr>
  <tr><td>Td</td><td>5</td></tr>
  <tr><td>N</td><td>5</td></tr>
  <tr><td>b</td><td>1</td></tr>
  <tr><td>c</td><td>1</td></tr>
  </table><br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/UnderShootingControlled.png\"><br>
  
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
  <TR bgcolor=#e0e0e0><TH>Parameter</TH><TH>Value</TH></TR>
  <tr><td>Kp</td><td>10</td></tr>
  <tr><td>Ti</td><td>2.5</td></tr>
  <tr><td>Td</td><td>1</td></tr>
  <tr><td>N</td><td>10</td></tr>
  <tr><td>b</td><td>1</td></tr>
  <tr><td>c</td><td>1</td></tr>
  </table><br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/ControlProblems/CompexPolesControlled.png\"><br>
  
  </p>
  
  </HTML>", revisions="<html>
<dl><dt>Industrial Control Systems (v 1.0.0) : April-May 2012</dt>
<dl><dt>List of revisions:</dt>
<p><ul>
<li>11 May 2012 (author: Marco Bonvini)</li>
</ul></p>
<dl><dt><b>Main Authors:</b> <br/></dt>
<dd>Marco Bonvini; &lt;<a href=\"mailto:bonvini@elet.polimi.it\">bonvini@elet.polimi.it</a>&gt;</dd>
<dd>Alberto Leva &lt;<a href=\"mailto:leva@elet.polimi.it\">leva@elet.polimi.it</a>&gt;<br/></dd>
<dd>Politecnico di Milano</dd>
<dd>Dipartimento di Elettronica e Informazione</dd>
<dd>Via Ponzio 34/5</dd>
<dd>20133 Milano - ITALIA -<br/></dd>
<dt><b>Copyright:</b> </dt>
<dd>Copyright &copy; 2010-2012, Marco Bonvini and Alberto Leva.<br/></dd>
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>.</i><br/></dd>
</dl></html>"));
end ProcessControl;

within IndustrialControlSystems.Applications.TrasferFunctions;
model TypicalTF
  "This model contains a set of typical process transfer functions"
  parameter Real mu_FO = 1 "|First Order| Gain";
  parameter Real T_FO = 5 "|First Order| Time constant";
  parameter Real mu_FOD = 1 "|First Order +  Delay| Gain";
  parameter Real T_FOD = 5 "|First Order +  Delay| Time constant";
  parameter Real delay_FOD = 2 "|First Order +  Delay| Time delay";
  parameter Real mu_i = 0.1 "|Integrator| Gain";
  parameter Real mu_iD = 0.1 "|Integrator +  Delay| Gain";
  parameter Real delay_iD = 2 "|Integrator +  Delay| Time delay";
  parameter Real mu_OS = 1 "|OverShooting system| Gain";
  parameter Real Tau_OS = 8 "|OverShooting system| Zero's time constant";
  parameter Real T1_OS = 5 "|OverShooting system| Dominant pole time constant";
  parameter Real T2_OS = 2 "|OverShooting system| Second pole time constant";
  parameter Real mu_US = 1 "|UnderShooting system| Gain";
  parameter Real Tau_US = -5.5 "|UnderShooting system| Zero's time constant";
  parameter Real T1_US = 5 "|UnderShooting system| Dominant pole time constant";
  parameter Real T2_US = 2 "|UnderShooting system| Second pole time constant";
  parameter Real mu = 1 "|Complex poles| Gain";
  parameter Real xi = 0.3 "|Complex poles| Damping coefficient";
  parameter Real omega = 0.5 "|Complex poles| Natural frequency";
  parameter Real mu_FS = 1 "|Fast-Slow system| Gain";
  parameter Real Tau_FS = 5.8 "|Fast-Slow system| Zero's time constant";
  parameter Real T1_FS = 6 "|Fast-Slow system| Dominant pole time constant";
  parameter Real T2_FS = 1 "|Fast-Slow system| Second pole time constant";

  LinearSystems.Continuous.FirstOrder firstOrder(tau=T_FO, mu=mu_FO)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  LinearSystems.Continuous.FirstOrder firstOrder1(tau=T_FOD, mu=mu_FOD)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  IndustrialControlSystems.LinearSystems.Continuous.Delay delay(T=delay_FOD)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  LinearSystems.Continuous.Integrator integrator(mu=mu_i)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  LinearSystems.Continuous.Integrator integrator1(mu=mu_iD)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  IndustrialControlSystems.LinearSystems.Continuous.Delay delay1(T=delay_iD)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Interfaces.RealInput FO_u "First Order input"
                                                  annotation (Placement(
        transformation(extent={{-120,70},{-80,110}}), iconTransformation(extent=
           {{-100,80},{-80,100}})));
  Modelica.Blocks.Interfaces.RealOutput FO_y "First Order output"
                                                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,70})));
  Modelica.Blocks.Interfaces.RealInput FOD_u "First Order+ Delay input"
                                                  annotation (Placement(
        transformation(extent={{-120,30},{-80,70}}), iconTransformation(extent={
            {-100,20},{-80,40}})));
  Modelica.Blocks.Interfaces.RealOutput FOD_y "First Order + Delay output"
                                                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,30}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,10})));
  Modelica.Blocks.Interfaces.RealInput i_u "Integrator input"
                                                  annotation (Placement(
        transformation(extent={{-120,-10},{-80,30}}), iconTransformation(extent=
           {{-100,-40},{-80,-20}})));
  Modelica.Blocks.Interfaces.RealOutput i_y "Integrator output"
                                                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,-10}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,-50})));
  Modelica.Blocks.Interfaces.RealInput iD_u "Integrator + Delay input"
                                                  annotation (Placement(
        transformation(extent={{-120,-50},{-80,-10}}), iconTransformation(
          extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Interfaces.RealOutput iD_y "Integrator + Delay output"
                                                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,-50}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,-110})));
  LinearSystems.Continuous.LeadLag leadLag(
    T1=Tau_OS,
    T2=T1_OS,
    mu=mu_OS)
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  LinearSystems.Continuous.FirstOrder firstOrder2(tau=T2_OS, mu=1)
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  LinearSystems.Continuous.LeadLag leadLag1(
    T1=Tau_US,
    T2=T1_US,
    mu=mu_US)
    annotation (Placement(transformation(extent={{-60,-120},{-40,-100}})));
  LinearSystems.Continuous.FirstOrder firstOrder3(           mu=1, tau=T2_US)
    annotation (Placement(transformation(extent={{-20,-120},{0,-100}})));
  Modelica.Blocks.Interfaces.RealInput OS_u "OverShooting input"
                                                  annotation (Placement(
        transformation(extent={{-120,-90},{-80,-50}}), iconTransformation(
          extent={{-100,-160},{-80,-140}})));
  Modelica.Blocks.Interfaces.RealOutput OS_y "OverShooting output"
                                                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,-90}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,-170})));
  Modelica.Blocks.Interfaces.RealInput US_u "UnderShooting input"
                                                  annotation (Placement(
        transformation(extent={{-120,-130},{-80,-90}}), iconTransformation(
          extent={{-100,-220},{-80,-200}})));
  Modelica.Blocks.Interfaces.RealOutput US_y "UnderShooting output"
                                                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,-130}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,-230})));
  Modelica.Blocks.Interfaces.RealInput Osc_u "Complex Poles input"
                                                  annotation (Placement(
        transformation(extent={{-120,-170},{-80,-130}}), iconTransformation(
          extent={{-100,-280},{-80,-260}})));
  Modelica.Blocks.Interfaces.RealOutput Osc_y "Complex Poles output"
                                                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,-170}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,-290})));
  LinearSystems.Continuous.ComplexPoles complexPoles(
    xi=xi,
    omegan=omega,
    mu=mu)
    annotation (Placement(transformation(extent={{-60,-160},{-40,-140}})));
  Modelica.Blocks.Interfaces.RealInput FS_u "Fast Slow input"
                                                  annotation (Placement(
        transformation(extent={{-120,-210},{-80,-170}}), iconTransformation(
          extent={{-100,-340},{-80,-320}})));
  Modelica.Blocks.Interfaces.RealOutput FS_y "Fast Slow output"
                                                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,-212}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-90,-350})));
  LinearSystems.Continuous.LeadLag leadLag2(
    T1=Tau_FS,
    T2=T1_FS,
    mu=mu_FS)
    annotation (Placement(transformation(extent={{-60,-200},{-40,-180}})));
  LinearSystems.Continuous.FirstOrder firstOrder4(           mu=1, tau=T2_FS)
    annotation (Placement(transformation(extent={{-20,-200},{0,-180}})));
equation
  connect(firstOrder.u, FO_u)
                            annotation (Line(
      points={{-58,90},{-100,90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(firstOrder.y, FO_y)
                            annotation (Line(
      points={{-41,90},{10,90},{10,70},{-90,70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(FOD_u, firstOrder1.u)
                             annotation (Line(
      points={{-100,50},{-58,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(firstOrder1.y, delay.u) annotation (Line(
      points={{-41,50},{-18,50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(delay.y, FOD_y)
                       annotation (Line(
      points={{-1,50},{10,50},{10,30},{-90,30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(i_u, integrator.u)
                            annotation (Line(
      points={{-100,10},{-79,10},{-79,10},{-58,10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(integrator.y, i_y)
                            annotation (Line(
      points={{-41,10},{10,10},{10,-10},{-90,-10}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(integrator1.y, delay1.u) annotation (Line(
      points={{-41,-30},{-18,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(iD_u, integrator1.u)
                             annotation (Line(
      points={{-100,-30},{-58,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(delay1.y, iD_y)
                        annotation (Line(
      points={{-1,-30},{10,-30},{10,-50},{-90,-50}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(OS_u, leadLag.u)
                         annotation (Line(
      points={{-100,-70},{-58,-70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(leadLag.y, firstOrder2.u) annotation (Line(
      points={{-41,-70},{-18,-70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(firstOrder2.y, OS_y)
                             annotation (Line(
      points={{-1,-70},{10,-70},{10,-90},{-90,-90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(US_u, leadLag1.u)
                          annotation (Line(
      points={{-100,-110},{-58,-110}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(leadLag1.y, firstOrder3.u) annotation (Line(
      points={{-41,-110},{-18,-110}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(firstOrder3.y,US_y)
                             annotation (Line(
      points={{-1,-110},{10,-110},{10,-130},{-90,-130}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Osc_u, complexPoles.u)
                              annotation (Line(
      points={{-100,-150},{-58,-150}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(complexPoles.y, Osc_y)
                              annotation (Line(
      points={{-41,-150},{10,-150},{10,-170},{-90,-170}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(FS_u, leadLag2.u) annotation (Line(
      points={{-100,-190},{-58,-190}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(leadLag2.y, firstOrder4.u) annotation (Line(
      points={{-41,-190},{-18,-190}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(firstOrder4.y, FS_y) annotation (Line(
      points={{-1,-190},{12,-190},{12,-212},{-90,-212}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -360},{100,100}}),
                         graphics), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-360},{100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-360}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-98,88},{102,64}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="First Order"),
        Text(
          extent={{-100,32},{100,8}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="First Order + D"),
        Text(
          extent={{-100,-30},{100,-54}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Integrator"),
        Text(
          extent={{-100,-90},{100,-114}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Integrator + D"),
        Text(
          extent={{-100,-152},{100,-176}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="OverShooting"),
        Text(
          extent={{-100,-210},{100,-234}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="UnderShooting"),
        Text(
          extent={{-100,-270},{100,-294}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Oscillating"),
        Text(
          extent={{-98,-330},{100,-352}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Fast Slow")}),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This model is a container of different trasfer functions that can model the typical processes.
  The parameters of each TF (listed in a table below), can be modified in order to adapt each process to the user's needs. 
  
  <br/>
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
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/TrasferFunction/Integrator.png\"><br>
  
  <br/>
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH colspan=2>Integrator + delay</TH></TR>
  <tr>
  <td colspan =2>
  <pre>
  Y(s)     1     -2s
  ---- = ----- e
  U(s)     5s  </pre>
  </td>
  </tr>
  </table><br><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/TrasferFunction/Int+Delay.png\"><br>
  
  <br/>
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
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/TrasferFunction/FirstOrder.png\"><br>
  
  <br/>
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
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/TrasferFunction/FirstOrder+Delay.png\"><br>
  </p>
  
  <br/>
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
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/TrasferFunction/FastSlow.png\"><br>
  
  <br/>
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
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/TrasferFunction/OverShooting.png\"><br>
  
  <br/>
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
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/TrasferFunction/UnderShooting.png\"><br>
  
  <br/>
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
  <img src=\"modelica://IndustrialControlSystems/help/images/Applications/TrasferFunction/ComplexPoles.png\"><br>
  
  </HTML>",
          revisions="<html>
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
end TypicalTF;

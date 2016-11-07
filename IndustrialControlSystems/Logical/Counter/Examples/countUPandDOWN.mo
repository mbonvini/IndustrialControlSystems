within IndustrialControlSystems.Logical.Counter.Examples;
model countUPandDOWN "test model of the counter"
  extends Modelica.Icons.Example;

  Counter counter
    annotation (Placement(transformation(extent={{-20,20},{20,60}})));
  Modelica.Blocks.Sources.IntegerConstant x0(k=5) annotation (Placement(
        transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Blocks.Sources.BooleanTable countUP(startValue=false, table=
        {10,11,12,13,14,15,16,17,18,19,20,21})
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Sources.BooleanTable countDOWN(startValue=false,
      table={25,26,27,28,29,30})
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Modelica.Blocks.Sources.BooleanTable set(startValue=false, table={1,40,55})
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Sources.BooleanTable reset(startValue=false, table={
        50,51})                              annotation (Placement(
        transformation(extent={{-100,-60},{-80,-40}})));
equation
  connect(x0.y, counter.PV) annotation (Line(
      points={{-19,-30},{-8,-30},{-8,24}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(reset.y, counter.R) annotation (Line(
      points={{-79,-50},{-46,-50},{-46,32},{-16,32}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(set.y, counter.S) annotation (Line(
      points={{-79,-10},{-52,-10},{-52,40},{-16,40}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(countDOWN.y, counter.CD) annotation (Line(
      points={{-79,30},{-60,30},{-60,48},{-16,48}},
      color={255,0,255},
      smooth=Smooth.None));
  connect(countUP.y, counter.CU) annotation (Line(
      points={{-79,70},{-60,70},{-60,56},{-16,56}},
      color={255,0,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics),
    experiment(StopTime=60),
    experimentSetupOutput,
    Documentation(revisions="<html>
<dl><dt>First release of the Industrial Control Systems: April-May 2012</dt>
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
<dd><i>The IndustrialControlSystems package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>, see the license conditions and the accompanying <b>disclaimer</b> in the documentation of package Modelica in file &quot;Modelica/package.mo&quot;.</i><br/></dd>
</dl></html>", info="<html>
<p>
In this example have been tested the basic functionalities of the Up and DOWN counter.

 At each time step <FONT FACE=Courier>Ts</FONT> the inputs are read and the new output values <FONT FACE=Courier>Q</FONT> and
  <FONT FACE=Courier>CV</FONT> are computed.<br><br>
  
  In the former image, are reported the <FONT FACE=Courier>S</FONT> (Set), <FONT FACE=Courier>R</FONT> (Reset), <FONT FACE=Courier>CU</FONT> (CountUP),
  <FONT FACE=Courier>CD</FONT> (CountDown) signals.<br>
  The latter images contains the <FONT FACE=Courier>CV</FONT> (Current Value) and the <FONT FACE=Courier>PV</FONT>(Preset Value).<br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Logical/Counter/Counter1.png\"><br>
  <img src=\"modelica://IndustrialControlSystems/help/images/Logical/Counter/Counter2.png\">
  <br><br>
  
  The counter update the <FONT FACE=Courier>CV</FONT> when the Set signal rises, then for each rising edge of the Count Up (<FONT FACE=Courier>CU</FONT>) 
  or Count Down (<FONT FACE=Courier>CD</FONT>) signals the <FONT FACE=Courier>CV</FONT> is incremented or decremented by 1.<br>
  The Set signal has to be high during this phase, otherwise the rising edges are not detected.<br>
  When the Reset (<FONT FACE=Courier>R</FONT>) signal rises, the counter is reset to zero.<br>
  </p>
  <p>
  <b>Constraints</b><br>
  The current value <FONT FACE=Courier>CV</FONT> must be
  <pre> 
  0 &lt;= CV &lt;= Max
  </pre>
  Where <FONT FACE=Courier>Max</FONT> is the module of the counter.
  </p>
</html>"));
end countUPandDOWN;

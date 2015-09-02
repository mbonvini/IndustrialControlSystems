within IndustrialControlSystems.Controllers.Interfaces;
partial model Block "Partial interface for a continuous time control block"

  Real tr "track reference value";
  Boolean ts "track reference signal";
  parameter Boolean useTS = false "|Tracking| =true, if TS input is enabled"
  annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Real eps = 0.001
    "|Tracking| Small time constant used in tracking mode"                          annotation(Evaluate = true);
  parameter Boolean AntiWindup = false
    "|Saturation| Flag that enables the antiwindup feature" annotation(Evaluate = true);
  parameter Real Ymin = 0 "|Saturation| Minimum value of Y" annotation(Evaluate = true);
  parameter Real Ymax = 1 "|Saturation| Maximum value of Y" annotation(Evaluate = true);
  Modelica.Blocks.Interfaces.RealInput TR if useTS "Track Reference signal "
                                                   annotation (Placement(
        transformation(
        origin={2,80},
        extent={{-20,-20},{20,20}},
        rotation=270)));

  Modelica.Blocks.Interfaces.BooleanInput TS if useTS "Track Switch signal"
                                                      annotation (Placement(
        transformation(
        origin={50,80},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Modelica.Blocks.Interfaces.RealInput u "input"
    annotation (Placement(transformation(extent={{-100,-20},{-60,20}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealOutput y "output"
    annotation (Placement(transformation(extent={{80,-10},{100,10}},
          rotation=0)));
protected
  Modelica.Blocks.Interfaces.RealInput TR_in;
  Modelica.Blocks.Interfaces.BooleanInput TS_in;
equation
  connect(TR_in, TR);
  connect(TS_in, TS);

  if not useTS then
    TR_in = 0;
    TS_in = false;
  end if;

  tr = TR_in;
    ts = TS_in;

  annotation (Diagram(graphics),
                       Icon(graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-98,126},{100,104}},
          lineColor={0,0,0},
          fillColor={85,85,255},
          fillPattern=FillPattern.Solid,
          textString=
               "%name")}),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Partial interface for a continuous time control block.<br>
  The block has one input and one output (SISO); additional inputs can be used for control purposes.<br>
  
  <h4>AntiWindUp mode</h4>
  If the boolean flag <FONT FACE=Courier>AntiWindup</FONT> is tue the output of the block ( <FONT FACE=Courier>y</FONT> ) saturates
  at the levels specified by <FONT FACE=Courier>Ymin</FONT> and <FONT FACE=Courier>Ymax</FONT>.
  
  <h4>Tracking mode</h4>
  If the boolean flag <FONT FACE=Courier>useTS</FONT>, the inputs <FONT FACE=Courier>TS</FONT> and <FONT FACE=Courier>TR</FONT> are enabled.<br>
  When enabled, is the <FONT FACE=Courier>TS</FONT> signal is true the output <FONT FACE=Courier>y</FONT> is forced to follow the track reference signal <FONT FACE=Courier>TR</FONT>.
  </p>
  </HTML>",
        revisions="<html>
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
</dl></html>"));
end Block;

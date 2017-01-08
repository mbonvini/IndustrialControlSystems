within IndustrialControlSystems.Controllers.Digital.Interfaces;
partial model Controller "Partial interface for a digital controller"
  Real bias "bias signal";
  Real tr "track reference value";
  Boolean ts "track reference signal";
  Real csInc "control signal increment when man mode is selected";
  Boolean man "manual enabling signal";
  Boolean F_inc "forbidden increment signal";
  Boolean F_dec "forbidden decrement signal";
  parameter Real Ts = 0 "|Discretisation| Sampling time" annotation(Evaluate=true);
  parameter Boolean AntiWindup = false
    "|Saturation| Flag that enables the antiwindup feature" annotation(Evaluate=true);
  parameter Real CSmin = 0 "|Saturation| minimum value of the CS"  annotation(Evaluate=true);
  parameter Real CSmax = 1 "|Saturation| maximum value of the CS"  annotation(Evaluate=true);
  parameter Real CS_start = 0 "|Initialisation| output initial value"  annotation(Evaluate=true);
  parameter Boolean useTS = false
    "|Attributes| =true, if TS and TR inputs are enabled"
  annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean useBIAS = false
    "|Attributes| =true, if BIAS input is enabled"
  annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean useMAN = false
    "|Attributes| =true, if MANUAL input is enabled"
  annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean useForbid = false
    "|Attributes| =true, if Forbid inputs are enabled"
  annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  Modelica.Blocks.Interfaces.RealInput TR if useTS "Track Reference signal"
                                                   annotation (Placement(
        transformation(
        origin={2,80},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80})));
  Modelica.Blocks.Interfaces.BooleanInput TS if useTS
    "Flag that enables the TRACKING mode"             annotation (Placement(
        transformation(
        origin={50,80},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={40,80})));
  Modelica.Blocks.Interfaces.RealInput BIAS if useBIAS "Bias signal"
                                                       annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,80})));
  Modelica.Blocks.Interfaces.BooleanInput MAN if useMAN
    "Flag that enables the MANUAL mode"                annotation (Placement(
        transformation(
        origin={-80,0},
        extent={{-20,-20},{20,20}},
        rotation=0),   iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-80,0})));
  Modelica.Blocks.Interfaces.RealInput CSinc if useMAN
    "Control Signal increment when MANUAL mode is selected"         annotation (
     Placement(transformation(extent={{-100,-60},{-60,-20}}),
        iconTransformation(extent={{-100,-60},{-60,-20}})));

  Modelica.Blocks.Interfaces.BooleanInput Finc if
                                                 useForbid
    "Flag that forbid an increment of the CS"          annotation (Placement(
        transformation(
        origin={-20,-80},
        extent={{-20,-20},{20,20}},
        rotation=0),   iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-40,-80})));
  Modelica.Blocks.Interfaces.BooleanInput Fdec if
                                                 useForbid
    "Flag that forbid a decrement of the CS"           annotation (Placement(
        transformation(
        origin={40,-80},
        extent={{-20,-20},{20,20}},
        rotation=0),   iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={20,-80})));
  Modelica.Blocks.Interfaces.RealInput SP "Set Point signal"
    annotation (                           Placement(transformation(extent={{-100,60},
            {-60,100}},     rotation=0),
                            iconTransformation(extent={{-100,60},{-60,100}})));
  Modelica.Blocks.Interfaces.RealOutput CS "Control signal"
    annotation (Placement(transformation(extent={{80,-10},{100,10}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealInput PV "Process Variable signal" annotation (
     Placement(transformation(extent={{-100,20},{-60,60}}),
        iconTransformation(extent={{-100,20},{-60,60}})));
protected
  Modelica.Blocks.Interfaces.RealInput TR_in;
  Modelica.Blocks.Interfaces.BooleanInput TS_in;
  Modelica.Blocks.Interfaces.RealInput BIAS_in;
  Modelica.Blocks.Interfaces.RealInput CSinc_in;
  Modelica.Blocks.Interfaces.BooleanInput MAN_in;
  Modelica.Blocks.Interfaces.BooleanInput Finc_in;
  Modelica.Blocks.Interfaces.BooleanInput Fdec_in;
public
  Modelica.Blocks.Interfaces.BooleanOutput satHI
    "The CS signal saturated at CSmax" annotation (Placement(
        transformation(extent={{80,50},{100,70}}), iconTransformation(
          extent={{80,50},{100,70}})));
  Modelica.Blocks.Interfaces.BooleanOutput satLOW
    "The CS signal saturated at CSmin" annotation (Placement(
        transformation(extent={{80,-70},{100,-50}}), iconTransformation(
          extent={{80,-70},{100,-50}})));
equation

  // conditional connectors
  connect(TR_in, TR);
  connect(TS_in, TS);
  connect(BIAS_in, BIAS);
  connect(CSinc_in,CSinc);
  connect(MAN_in,MAN);
  connect(Finc_in,Finc);
  connect(Fdec_in,Fdec);

  if not useTS then
    TR_in = 0;
    TS_in = false;
  end if;

  if not useBIAS then
    BIAS_in = 0;
  end if;

  if not useMAN then
    MAN_in = false;
    CSinc_in  = 0;
  end if;

  if not useForbid then
    Finc_in = false;
    Fdec_in = false;
  end if;

  tr    = TR_in;
  ts    = TS_in;
  bias  = BIAS_in;
  csInc = CSinc_in;
  man   = MAN_in;
  F_inc = Finc_in;
  F_dec = Fdec_in;

  annotation (Diagram(graphics),
                         Icon(graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={213,255,170},
          fillPattern=FillPattern.Solid),
          Text(
            extent={{-100,-110},{100,-134}},
            lineColor={0,0,0},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid,
            textString="%name")}),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Partial interface for a digital controller, implemented through an algorithm.<br>
  The model has the following ports
  <br/>
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH >Name</TH><TH>Description</TH><TH>Conditional?</TH></TR>
  <tr>  <td>SP</td><td>Set Point</td><td>NO</td></tr>
  <tr>  <td>PV</td><td>Process Variable</td><td>NO</td></tr>
  <tr>  <td>CS</td><td>Control Signal</td><td>NO</td></tr>
  <tr>  <td>satHI</td><td>CS at HIGH saturation</td><td>NO</td></tr>
  <tr>  <td>satLOW</td><td>CS at LOW saturation</td><td>NO</td></tr>
  <tr>  <td>TR</td><td>Track Reference signal</td><td>YES (useTS)</td></tr>
  <tr>  <td>TS</td><td>Track Switch signal</td><td>YES (useTS)</td></tr>
  <tr>  <td>Bias</td><td>Biasing signal</td><td>YES (useBIAS)</td></tr>
  <tr>  <td>MAN</td><td>Manual Switch signal</td><td>YES (useMAN)</td></tr>
  <tr>  <td>CSinc</td><td>Control Signal increment</td><td>YES (useMAN)</td></tr>
  <tr>  <td>Finc</td><td>Forbid increment</td><td>YES (useForbid)</td></tr>
  <tr>  <td>Fdec</td><td>Forbid decrement</td><td>YES (useForbid)</td></tr>
  </table>
  <br/><br/>
  And some of them can be conditionally selected, by specifying a boolean flag.
  <br/>
  
  <h4>AntiWindUp mode</h4>
  If the boolean flag <FONT FACE=Courier>AntiWindup</FONT> is tue the output of the block ( <FONT FACE=Courier>CS</FONT> ) saturates
  at the values specified by <FONT FACE=Courier>CSmin</FONT> and <FONT FACE=Courier>CSmax</FONT>.
  
  <h4>Tracking mode</h4>
  If the boolean flag <FONT FACE=Courier>useTS</FONT> is true, the inputs <FONT FACE=Courier>TS</FONT> and <FONT FACE=Courier>TR</FONT> are enabled.<br>
  When enabled, if the <FONT FACE=Courier>TS</FONT> signal is true the output <FONT FACE=Courier>CS</FONT> is forced to follow the track reference signal <FONT FACE=Courier>TR</FONT>.
  </p>
  
  <h4>Manual mode</h4>
  If the boolean flag <FONT FACE=Courier>useMAN</FONT> is true, the inputs <FONT FACE=Courier>MAN</FONT> and <FONT FACE=Courier>CSinc</FONT> are enabled.<br>
  When enabled, if the <FONT FACE=Courier>MAN</FONT> signal is true the output <FONT FACE=Courier>CS</FONT> can be manually controlled via the signals 
  <FONT FACE=Courier>CSinc</FONT> and <FONT FACE=Courier>CSdec</FONT>, that respectively increment or decrement the control signal.
  
  <h4>Forbid mode</h4>
  If the boolean flag <FONT FACE=Courier>useForbid</FONT> is true, the inputs <FONT FACE=Courier>Finc</FONT> and <FONT FACE=Courier>Fdec</FONT> are enabled.<br>
  When enabled, if the <FONT FACE=Courier>Finc</FONT> signal is true the output <FONT FACE=Courier>CS</FONT> cannot grow up, while if 
  <FONT FACE=Courier>Fdec</FONT> is true it cannot decrease.
  </p>
  </p>
  </p>
  <h4>Discretisation</h4>
  The controller is implemented directly through an algorithm, that represents the discretised version of the continuous time controller.
  </p>
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
end Controller;

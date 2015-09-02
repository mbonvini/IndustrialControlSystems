within IndustrialControlSystems.Controllers.Interfaces;
partial model Controller "Partial interface for a generic controller"
  Real bias "bias signal";
  Real tr "track reference value";
  Boolean ts "track reference signal";
  Boolean at_req "auto tuning enabling signal";
  parameter Real Ts = 0
    "|Discretisation| Sampling time (if <= 0 continuous time)"                     annotation(Evaluate=true);
  parameter IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod method=
      IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.BE
    "|Discretisation| Discretisation method" annotation(Evaluate=true);
  parameter Boolean AntiWindup = false
    "|Saturation| Flag that enables the antiwindup feature" annotation(Evaluate=true);
  parameter Real CSmin = 0 "|Saturation| minimum value of the CS"  annotation(Evaluate=true);
  parameter Real CSmax = 1 "|Saturation| maximum value of the CS"  annotation(Evaluate=true);
  parameter Real CS_start = 0 "|Initialisation| output initial value"  annotation(Evaluate=true);
  parameter Real eps = 1e-6 "|Attributes| small time constant that represents the time for switching 
                            between auto and tracking mode"  annotation(Evaluate=true);
  parameter Boolean useTS = false
    "|Attributes| =true, if TS and TR inputs are enabled"
  annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean useBIAS = false
    "|Attributes| =true, if BIAS input is enabled"
  annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
  parameter Boolean useAT = false
    "|Attributes| =true, if AutoTuning input is enabled"
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
  Modelica.Blocks.Interfaces.BooleanInput TS if useTS "Track Switch signal"
                                                      annotation (Placement(
        transformation(
        origin={50,80},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={40,80})));
  Modelica.Blocks.Interfaces.RealInput BIAS if useBIAS "Bias"
                                                       annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,80})));
  Modelica.Blocks.Interfaces.RealInput SP "Set Point signal"
    annotation (                           Placement(transformation(extent={{-100,
            -20},{-60,20}}, rotation=0),
                            iconTransformation(extent={{-100,40},{-60,80}})));
  Modelica.Blocks.Interfaces.RealOutput CS "Control signal"
    annotation (Placement(transformation(extent={{80,-10},{100,10}},
          rotation=0)));
  Modelica.Blocks.Interfaces.RealInput PV "Process Variable signal" annotation (
     Placement(transformation(extent={{-100,-66},{-60,-26}}),
        iconTransformation(extent={{-100,-30},{-60,10}})));
  Modelica.Blocks.Interfaces.BooleanInput ATreq if useAT "Auto Tuning request"
                                                          annotation (Placement(transformation(extent={{-100,-80},{-60,-40}},
          rotation=0), iconTransformation(extent={{-100,-100},{-60,-60}})));
protected
  Modelica.Blocks.Interfaces.RealInput TR_in;
  Modelica.Blocks.Interfaces.BooleanInput TS_in;
  Modelica.Blocks.Interfaces.BooleanInput ATreq_in;
  Modelica.Blocks.Interfaces.RealInput BIAS_in;
  Real alfa "discretisation coefficient";
equation

  // definition of the discretising coefficient
  if method == IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.BE then
    alfa = 1;
  elseif method == IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.FE then
    alfa = 0;
  elseif method == IndustrialControlSystems.LinearSystems.Discrete.Types.discrMethod.TU then
    alfa = 0.5;
  else
    alfa = 1;
  end if;

  // conditional connectors
  connect(TR_in, TR);
  connect(TS_in, TS);
  connect(BIAS_in, BIAS);
  connect(ATreq_in,ATreq);

  if not useTS then
    TR_in = 0;
    TS_in = false;
  end if;

  if not useBIAS then
    BIAS_in = 0;
  end if;

  if not useAT then
    ATreq_in = false;
  end if;

  tr = TR_in;
  ts = TS_in;
  bias = BIAS_in;
  at_req = ATreq_in;

  annotation (Diagram(graphics),
                         Icon(graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={170,255,85},
          fillPattern=FillPattern.Solid),
          Text(
            extent={{-98,-110},{102,-134}},
            lineColor={0,0,0},
            fillColor={170,170,255},
            fillPattern=FillPattern.Solid,
            textString="%name")}),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Partial interface for a continuous/discrete time controller.<br>
  The model has the following ports
  <br/>
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH >Name</TH><TH>Description</TH><TH>Conditional?</TH></TR>
  <tr>  <td>SP</td><td>Set Point</td><td>NO</td></tr>
  <tr>  <td>PV</td><td>Process Variable</td><td>NO</td></tr>
  <tr>  <td>CS</td><td>Control Signal</td><td>NO</td></tr>
  <tr>  <td>TR</td><td>Track Reference signal</td><td>YES (useTS)</td></tr>
  <tr>  <td>TS</td><td>Track Switch signal</td><td>YES (useTS)</td></tr>
  <tr>  <td>Bias</td><td>Biasing signal</td><td>YES (useBIAS)</td></tr>
  <tr>  <td>ATreq</td><td>AutoTuning request</td><td>YES (useAT)</td></tr>
  </table>
  <br/><br/>
  And some of them can be conditionally selected, by specifying a boolean flag.
  <br/><br/>
  
  <h4>AntiWindUp mode</h4>
  If the boolean flag <FONT FACE=Courier>AntiWindup</FONT> is tue the output of the block ( <FONT FACE=Courier>CS</FONT> ) saturates
  at the values specified by <FONT FACE=Courier>CSmin</FONT> and <FONT FACE=Courier>CSmax</FONT>.
  
  <h4>Tracking mode</h4>
  If the boolean flag <FONT FACE=Courier>useTS</FONT>, the inputs <FONT FACE=Courier>TS</FONT> and <FONT FACE=Courier>TR</FONT> are enabled.<br>
  When enabled, if the <FONT FACE=Courier>TS</FONT> signal is true the output <FONT FACE=Courier>CS</FONT> is forced to follow the track reference signal <FONT FACE=Courier>TR</FONT>.
  </p>
  </p>
  <h4>Discretisation</h4>
  For each controller is defined a sampling time <FONT FACE=Courier>Ts</FONT> and a coefficient alpha.<br>
  The discretisation of the continuos time transfer function has been performed with the bilinear transformation formula
  <pre>
                 z - 1 
  s = ------------------------------
        z*alpha*Ts - (alpha - 1)*Ts
  </pre>
  that is equivalent to<br>
  <ul>
  <li>Forward Euler (FE) if <pre><FONT FACE=Courier>alpha = 0</FONT></pre></li>
  <li>Backward Euler (BE) if <pre><FONT FACE=Courier>alpha = 1</FONT></pre></li>
  <li>Tustin (TU) if <pre><FONT FACE=Courier>alpha = 0.5</FONT></pre></li>
  </ul>
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
end Controller;

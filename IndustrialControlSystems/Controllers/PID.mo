within IndustrialControlSystems.Controllers;
model PID
  "Proportional + Integral + Derivative two degree of freedom controller"
  extends Interfaces.Controller;
  parameter Real Kp = 5 "|Parameters| Proportional gain" annotation(Evaluate = true);
  parameter Real Ti = 1 "|Parameters| Integral time" annotation(Evaluate = true);
  parameter Real Tt = max(1e3*eps,sqrt(Ti*Td))
    "|Parameters| Reset time for the integrator (it should be larger than Td and smaller than Ti)"
                                                                                                        annotation(Evaluate = true);
  parameter Real Td = 1 "|Parameters| Derivative time" annotation(Evaluate = true);
  parameter Real N =  10 "|Parameters| Derivative filter ratio"  annotation(Evaluate = true);
  parameter Real b = 1
    "|Parameters| Set point weighting for the proportional action" annotation(Evaluate=true);
  parameter Real c = 1
    "|Parameters| Set point weighting for the derivative action" annotation(Evaluate=true);
  Real Paction "proportional action";
  Real Iaction "integral action";
  Real Daction "derivative action";
  Real Fder "filtered weigthed error";
  Real satin "saturation input";
  Real satDiff "difference between saturation input and output signals";
  Real cs "Control Signal before the biasing";
initial equation

  if Ts > 0 then
    // Discrete time initialisation
    pre(Iaction) = 0;
    pre(Fder)    = 0;
  else
    // Continuous time initialisation
    Iaction = 0;
    Fder    = 0;
  end if;

equation
  assert(Ti>0, "Integral time must be positive");
  assert(Tt>0, "Reset time must be positive");
  assert(Td>=0,"derivative time must be >= 0");

  if Ts > 0 then
    // Discrete time controller
    when sample(0,Ts) then
      // proportional action
      Paction = Kp*(b*SP - PV);
      // integral action
      //Iaction = ControlLibrary.LinearSystems.Discrete.Functions.fIntegrator(alfa,Kp/Ti*(SP-PV)+ 1/Tt*satDiff,Kp/Ti*(pre(SP)-pre(PV))+1/Tt*pre(satDiff),pre(Iaction),Ts,1);
      if not ts then
        Iaction =
          IndustrialControlSystems.LinearSystems.Discrete.Functions.fIntegrator(
          alfa,
          Kp/Ti*(SP - PV) + 1/Tt*satDiff,
          Kp/Ti*(pre(SP) - pre(PV)) + 1/Tt*pre(satDiff),
          pre(Iaction),
          Ts,
          1);
      else
        Iaction =
          IndustrialControlSystems.LinearSystems.Discrete.Functions.f1Pole(
          alfa,
          cs,
          pre(cs),
          pre(Iaction),
          Ts,
          1,
          eps);
      end if;
      // derivative action
      Daction = Kp*N*(c*SP - PV) - Fder;
      Fder = if Td > 0 then
        IndustrialControlSystems.LinearSystems.Discrete.Functions.f1Pole(
        alfa,
        c*SP - PV,
        c*pre(SP) - pre(PV),
        pre(Fder),
        Ts,
        Kp*N,
        Td/N) else 0;

      // sum of the three actions
      satin = Iaction + Paction + (if Td>0 then Daction else 0);

      // Anti-windup
      cs = if AntiWindup then max(CSmin,min(CSmax,(if ts then tr else satin))) else (if ts then tr else satin);

      // Signal for preventing antiwindup (integrator reset signal)
      satDiff = cs - satin;

      // biasing the output
      CS = if AntiWindup then max(CSmin,min(CSmax,cs + pre(bias))) else cs + pre(bias);

    end when;
  else
    // Continuous time controller

    // proportional action
    Paction = Kp*(b*SP - PV);

    // integral action
    if not ts then
      der(Iaction) = Kp/Ti*(SP - PV) + 1/Tt*satDiff;
    else
      Iaction + eps*der(Iaction) = cs;
    end if;

    // derivative action
    Daction = Kp*N*(c*SP - PV) - Fder;
    Fder    = if Td >0 then (-Td/N*der(Fder) + Kp*N*(c*SP - PV)) else 0;

    // sum of the three actions
    satin = Iaction + Paction + (if Td>0 then Daction else 0);

    // Anti-windup
    cs = if AntiWindup then max(CSmin,min(CSmax,(if ts then tr else satin))) else (if ts then tr else satin);

    // Signal for preventing antiwindup (integrator reset signal)
    satDiff = cs - satin;

    // biasing the output
    CS = if AntiWindup then max(CSmin,min(CSmax,cs + bias)) else cs + bias;

  end if;
  annotation (Diagram(graphics), Icon(graphics={
                             Text(
          extent={{-40,26},{50,-50}},
          lineColor={0,0,255},
          textString="PID")}),Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  Proportional + Integral + Derivative with two degree of freedom controller with Automatic, Tracking mode and bias signal.<br/>
  The control law is defined as
  <pre>
            [                      1                        sTd                      ]
  CS(s) = Kp[ (bSP(s) - PV(s)) + ----- (SP(s) - PV(S)) + -----------(cSP(s) - PV(s)) ]
            [                     sTi                     1 + sTd/N                  ]
  </pre>
  <br/><br/>
  <b>Scheme</b><br/><br/>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/PID.png\">
  <br/><br/>
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH >Name</TH><TH>Description</TH><TH>Conditional?</TH></TR>
  <tr>  <td>SP</td><td>Set Point</td><td>NO</td></tr>
  <tr>  <td>PV</td><td>Process Variable</td><td>NO</td></tr>
  <tr>  <td>CS</td><td>Control Signal</td><td>NO</td></tr>
  <tr>  <td>TR</td><td>Track Reference signal</td><td>YES (useTS)</td></tr>
  <tr>  <td>TS</td><td>Track Switch signal</td><td>YES (useTS)</td></tr>
  <tr>  <td>Bias</td><td>Biasing signal</td><td>YES (useBIAS)</td></tr>
  <tr>  <td>ATreq</td><td>AutoTuning request</td><td>YES (*)</td></tr>
  </table>
  (*) AutoTuning Not available here, please see the package<br>
  <a href=\"Modelica://IndustrialControlSystems.Controllers.AutoTuning\">AutoTuning</a>
  <br/><br/>
  The controller can have various operating conditions:
  <ul>
  <li>Automatic,</li>
  <li>and Tracking</li>
  </ul><br/>
  
  In the Automatic mode, the control output is computed with the integral control law, while in the tracking mode<br>
  it is defined by the input TR.<br/><br/>
  To note that in the tracking mode the output of the integral block is forced to follow the track reference
  <pre>
              1
  I(s) = ---------- TR(S)
           1+s*eps
  </pre> 
  where eps is a small time constant. Thanks to such a scheme, the integrator does not diverge while the tracking mode<br>
  is enabled.
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
end PID;

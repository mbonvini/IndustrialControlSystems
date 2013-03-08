within IndustrialControlSystems.Controllers.AutoTuning;
model ATPIrelayNCdigital
  "PI controller with Auto Tuning algorithm - discrete time version -"
  extends IndustrialControlSystems.Controllers.Interfaces.Controller(final
      useAT=true);
  import Modelica.Constants.*;
  parameter Real Kp = 5 "|Parameters| Proportional gain (initial value)" annotation(Evaluate = true);
  parameter Real Ti = 1 "|Parameters| Integral time (initial value)" annotation(Evaluate = true);
  parameter Real slope = 1 "|Auto Tuning Algorithm| Slope of the signal";
  parameter Real permOxPeriodPerc = 5
    "|Auto Tuning Algorithm| allowed % difference between period measurements";
  parameter Real pm = 45 "|Auto Tuning Algorithm| Phase Margin required";
  parameter Integer nOxMin = 3
    "|Auto Tuning Algorithm| minimum number of oscillations";
  discrete Real K;
  discrete Real TI;
  discrete Integer iMode " 0: PI, 1: AT";
protected
  discrete Boolean UP;
  discrete Real lastToggleUp;
  discrete Real period;
  discrete Real wox;
  discrete Real Pox;
  discrete Real rPVmax;
  discrete Real rPVmin;
  discrete Real rCSmax;
  discrete Real rCSmin;
  discrete Real e;
  discrete Real CSp;
  discrete Real CSi;
  discrete Integer nOx;
algorithm
  // the sampling time must be greater than zero
  assert(Ts>0,"This is a discrete time controller, Ts MUST be >0");

  // Initial set of parameters (before auto tuning)
  when initial() then
       iMode := 0;
       K     := Kp;
       TI    := Ti;
  end when;

  // Events that starts the Auto Tuning phase
  when at_req == true then
       iMode := 1;
  end when;

  // State machine that represent the behaviour of the controller
  // when iMode == 0 it acts as a standard PI controller,
  // when iMode == 1 the tuning phase is activated
  when sample(0,Ts) then

    // error signal
    e  := SP-PV;

    // Normal PI mode
    if iMode==0 then          // PI
        CSp := K*e;
        CSi := pre(CSi) + K*Ts/TI*e;
        CS  := if ts then tr else CSp + CSi + bias;
        if CS>CSmax then
           CS:=CSmax;
        end if;
        if CS<CSmin then
           CS:=CSmin;
        end if;
        CSi := if ts then tr else CS - CSp - bias;
    end if;
    // AutoTuning PHASE
    if iMode==1 then          // AT
        // 1st step, initialise test
        if pre(iMode)==0 then
           wox          := 0;
           Pox          := 0;
           rPVmax       := PV;
           rPVmin       := PV;
           rCSmax       := CS;
           rCSmin       := CS;
           lastToggleUp := time;
           nOx          := 0;
        end if;

        // Manage relay
        if UP==false and PV<=SP then
           UP    := true;
        end if;
        if UP==true and PV>SP then
           UP    := false;
        end if;
        if UP==true then
           CS := CS + slope*Ts;
        else
           CS := CS - slope*Ts;
        end if;

        // record relay id max and min for PV and CS
        if PV>rPVmax then
           rPVmax := PV;
        end if;
        if PV<rPVmin then
           rPVmin := PV;
        end if;
        if CS>rCSmax then
           rCSmax := CS;
        end if;
        if CS<rCSmin then
           rCSmin := CS;
        end if;

        // toggled up, compute ox data and tune if perm
        if UP==true and pre(UP)==false then
           // count and measure the period and number of oscillations
           period       := time-lastToggleUp;
           lastToggleUp := time;

           // if the number of induced oscillations is higher than the minimum
           // required number, then compute the controller parameters
           if period>0 and nOx>=nOxMin
              and abs(period-pre(period))/period < permOxPeriodPerc/100 then
              iMode  := 0;
              wox    := 2*Modelica.Constants.pi/period;
              Pox    := Modelica.Constants.pi^2*(rPVmax-rPVmin)/8/(rCSmax-rCSmin);
              TI     := tan(pm/180*Modelica.Constants.pi)/wox;
              K      := tan(pm/180*Modelica.Constants.pi)/(Pox*sqrt(1+(tan(pm/180*Modelica.Constants.pi))^2));
              CSi    := CS-K*Ts/TI*e;
           end if;
           rPVmax       := PV;
           rPVmin       := PV;
           rCSmax       := CS;
           rCSmin       := CS;
           nOx          := nOx+1;
        end if;
   end if;
end when;

  annotation (Icon(graphics={
        Text(
          extent={{-42,50},{42,28}},
          lineColor={0,0,0},
          textString="AUTO"),
        Text(
          extent={{-42,12},{44,-24}},
          lineColor={0,0,0},
          textString="PI"),
        Text(
          extent={{-76,-40},{80,-66}},
          lineColor={0,0,0},
          textString="digital")}),       Diagram(graphics),
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
</dl></html>", info="<HTML>
  <h4>Description</h4>
  <p>
  Proportional + Integral controller with AutoTuning, Automatic, Tracking mode and bias signal.<br/>
  The control law is defined as
  <pre>
              1+sTi 
  CS(s) = Kp ------- (SP(s) - PV(S))
               sTi
  </pre>
  <br/><br/>
  <b>Scheme</b><br/><br/>
  <img src=\"modelica://IndustrialControlSystems/help/images/Controllers/PropInt.png\">
  <br/><br/>
  <TABLE BORDER=1 CELLSPACING=0 CELLPADDING=2 >
  <TR bgcolor=#e0e0e0><TH >Name</TH><TH>Description</TH><TH>Conditional?</TH></TR>
  <tr>  <td>SP</td><td>Set Point</td><td>NO</td></tr>
  <tr>  <td>PV</td><td>Process Variable</td><td>NO</td></tr>
  <tr>  <td>CS</td><td>Control Signal</td><td>NO</td></tr>
  <tr>  <td>TR</td><td>Track Reference signal</td><td>YES (useTS)</td></tr>
  <tr>  <td>TS</td><td>Track Switch signal</td><td>YES (useTS)</td></tr>
  <tr>  <td>Bias</td><td>Biasing signal</td><td>YES (useBIAS)</td></tr>
  <tr>  <td>ATreq</td><td>AutoTuning request</td><td>YES (useAT)</td></tr>
  </table><br/><br/>
  The controller can have various operating conditions:
  <ul>
  <li>Automatic,</li>
  <li>Auto Tuning,</li>
  <li>and Tracking</li>
  </ul><br/>
  
  In the Automatic mode, the control output is computed with the proportional+integral control law, while in the tracking mode<br>
  it is defined by the input TR.<br/><br/>
  </p>
  <h4>Auto Tuning</h4>
  <p>
  This section presents the Modelica realisations of the fully digital of the considered autotuning methodology.

  The block inputs are the set point (SP) and the process variable (PV), plus a boolean one, a pulse on which
  initiates the autotuning procedure; the output is clearly the control signal (CS).
  The initial values for K and Ti, as well as the required phase margin pm, are provided as parameters.
  
  The autotuning procedure is composed of the following steps:
  <ul>
  <li>start with the controller in PI mode;</li>
  <li>when the AT pulse is received,</li>
        <ul>
        <li>initialise the relay plus integrator control,</li>
        <li>connect it to the process,</li>
        <li>and wait for a permanent oscillation;</li>
        </ul>
        in the quite simple procedure presented here, an oscillation is considered permanent when the 
        difference between its period and that of the previous one is less than a percent defined as parameter,
        while - for the sake of safety in the face of possible outliers - a certain number of oscillations, 
        defined as a parameter too, is counted unconditionally before proceeding;</li>
  <li>when a permanent oscillation is detected, compute its frequency (wox), and by means of the following equation
  determine the corresponding process frequency response magnitude (the phase is -90 degrees);
  <br><pre>
  Pox    := pi^2*(rPVmax-rPVmin)/8/(rCSmax-rCSmin)
  </pre>
  </li>
  <li>apply equations
  <br><pre>
  TI     := tan(pm/180*pi)/wox
  K      := tan(pm/180*pi)/(Pox*sqrt(1+(tan(pm/180*pi))^2))
  </pre>
  to tune the regulator, and finally switch back to PI mode.</li>
  </ul><br><br>
  It is worth noticing that any industrial realisation would be more articulated than those illustrated in the following.
  For example, some logic would need introducing to abort the procedure in the case of unexpected and/or possibly harmful 
  system behaviours, a confirmation should be requested to the operator in order to accept or decline the proposed
  parameters prior to updating the PI, and so forth. Such features are however omitted here since they are lengthy to
  discuss in the necessary detail, and substantially inessential for the purpose of this work.
  <br>
  <h4>References</h4>
  For more information please refers to the following
  <a href=\"modelica://IndustrialControlSystems/help/refs/EffHybPITuning.pdf\">paper</a>:<br><br>
  <b>Efficient hybrid simulation of autotuning PI controllers</b><br>
  Alberto Leva, Marco Bonvini<br>
  8th Modelica Conference, Dresden, Germany<br>
  march 20-22, 2011<br>
  </p>
    </HTML>"));
end ATPIrelayNCdigital;

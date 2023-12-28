#!/bin/bash
# 物品[荆棘]没有完成战斗中伤害增加以及isrange的计算,[魔药]没做
# 欢迎信息
echo "欢迎来到战斗游戏！请输入你的名称："
read player_name
dblevel=1
# 初始化道具
dj=false
dj1=false
dj2=false
# 玩家属性
player_health=200
player_attack=20
player_critical_rate=10 # 玩家暴击率为10%
player_critical_damage=2 # 玩家暴击伤害加成为2倍
sblpy=5
isdj1=false
isdj2=false
range=0
# 敌人属性
enemy_health=80
enemy_attack=15
enemy_critical_rate=10 # 敌人暴击率为20%
enemy_critical_damage=1 # 敌人暴击伤害加成为2倍
issbey=false
sbley=1

# 临时敌人属性
tenemy_health=80
tenemy_attack=15
tenemy_critical_rate=20 # 敌人暴击率为20%
tenemy_critical_damage=1 # 敌人暴击伤害加成为2倍
# 游戏属性
level=1 # 当前层数

# 开始游戏
echo "你好，$player_name！准备好开始战斗了吗？"

while true
do
    t=$tenemy_health
    echo "当前层数：$level"
    echo -e "你的生命值：\033[34m $player_health \e[0m"
    echo -e "敌人的生命值：\033[31m $enemy_health \e[0m"

    # 玩家操作菜单
    echo "请选择你的行动："
    echo "1. 攻击敌人"
    echo "2. 使用物品"
    echo "0. 退出游戏"
    read action

    case $action in
        1)
            # 玩家攻击
            is_player_critical=false
            is_enemy_critical=false

            # 判断玩家是否暴击
            random_value=$((RANDOM % 100))
            if [ $random_value -lt $player_critical_rate ]; then
                is_player_critical=true
            fi

            # 判断敌人是否暴击
            random_value=$((RANDOM % 100))
            if [ $random_value -lt $enemy_critical_rate ]; then
                is_enemy_critical=true
            fi

            if [ $is_player_critical = true ]; then
	random_value=$((RANDOM % 100))
	if [ $random_value -lt $sbley ]; then
		echo -e "\033[33m敌人Miss了你的伤害\e[0m"
	else
               		player_damage=$((player_attack * player_critical_damage))
                	echo -e "你发动了\033[33m暴击\e[0m！造成了 \033[34m $player_damage \e[0m 点伤害！"
	fi
            else
	if [ $random_value -lt $sbley ]; then
		echo -e "\033[33m敌人Miss了你的伤害\e[0m"
	else
                player_damage=$player_attack
                echo -e "你对敌人造成了 \033[34m $player_attack \e[0m 点伤害！"
	fi
            fi


            if [ $is_enemy_critical = true ]; then
	random_value=$((RANDOM % 100))
	if [ $random_value -lt $sblpy ]; then
		echo -e "\033[33m你Miss了敌人的伤害\e[0m"
	else
                enemy_damage=$((enemy_attack * enemy_critical_damage))
                echo -e "敌人发动了\033[33m暴击\e[0m！对你造成了 \033[31m $enemy_damage \e[0m 点伤害！"
	fi
            else
	if [ $random_value -lt $sblpy ]; then
		echo -e "\033[33m你Miss了敌人的伤害\e[0m"
	else
                enemy_damage=$enemy_attack
                echo -e "敌人对你造成了 \033[31m $enemy_attack \e[0m 点伤害！"
	fi
            fi

            # 更新双方生命值
            tpa=$player_attack 
            enemy_health=$((enemy_health - player_damage))
            player_health=$((player_health - enemy_damage))
            if [ $player_health -le 0 ]; then
                echo "你被敌人打败了！游戏结束。"
                exit 0
            fi
            if [ $enemy_health -le 0 ]; then
	clear
                echo "你战胜了敌人！"
	tp1=$((player_attack + 5 * level))
	tp2=$((player_health + 100 * level))
	tp3=$((player_critical_rate + 5))
	tp4=$((player_critical_damage + 1))
	tp5=$((sblpy +1))
	
                t1=$((tenemy_health + 5))
                t2=$((enemy_attack + 3))
                t3=$((enemy_critical_rate + 1))
                t4=$((enemy_critical_damage + 1))
	if [ $level == $dblevel ]; then
	t5=$((sbley + 1))
	fi
	echo -e "敌人 \033[31m加强\e[0m"
	echo "敌人生命值 $t >> $t1 "
	echo "敌人攻击力 $enemy_attack >> $t2"
	echo "敌人暴击率 $enemy_critical_rate % >> $t3 %"
	echo "敌人暴击伤害 $enemy_critical_damage 00% >> $t4 00%"
	echo "敌人闪避率 $sbley % >> $t5 %"
	echo ""
	echo ""
                
                
            while true
                do
                # 增益选择
                echo "请选择一个增益："
                echo "1. 攻击力加成      $player_attack >> $tp1"
                echo "2. 生命值加成      $player_health >> $tp2"
                echo "3. 暴击率加成      $player_critical_rate % >> $tp3 %"
                echo "4. 暴击伤害加成    $player_critical_damage 00% >> $tp4 00%"
	            echo "5. 闪避率提升      $sblpy % >> $tp5 %"
                read boost
                case $boost in
                    1)
	        
                        player_attack=$((player_attack + 5 * level))
                        echo -e "你的攻击力增加了 \033[32m$((player_attack - tpa))\e[0m 点！"
                        break
                        ;;
                    2)
	        
                        player_health=$((player_health + 100 * level))
                        echo -e "你的生命值增加了 \033[32m$((2 * 50 * level))\e[0m 点！"
                        break
                        ;;
                    3)
	        
                        player_critical_rate=$((player_critical_rate + 5))
                        echo -e "你的暴击率增加了 \033[32m5%\e[0m !"
                        break
                        ;;
                    4)
	       
                        player_critical_damage=$((player_critical_damage + 1))
                        echo -e "你的暴击伤害加成增加了 \033[32m1\e[0m倍"
                        break
                        ;;
	                5)
	                    sblpy=$((sblpy +1))
	                    echo -e "你的闪避率增加了 \033[32m1%\e[0m"
                        break
	                    ;;
                    *)
                        echo "无效的选择。"
                        ;;
                esac
            done
    while true
    do
	if [ $level == $dblevel ]; then
	echo "选择一个道具:"
	echo "1. 荆棘(使用后3层内受到的伤害增加100%,效果结束后增加30%闪避率,持续5层)"
	echo "2. 魔药(使用后全属性增加100%,持续1层)"
<<<<<<< HEAD
	echo "3. 我!不!要!"
=======
	echo "2. 我!不!要!"
>>>>>>> c105bd0937b57835808433edc1aaec88fb414e8f
	read boostt
	case $boostt in
	1)
	   echo "获得荆棘(物品不叠加)"
	dj1=true
       	break
	  ;;
	3)
	   echo "你很勇哦"
       break
	  ;;
	2)
	   echo "魔药(物品不叠加)"
	   dj2=true
<<<<<<< HEAD
	   ;;
=======
>>>>>>> c105bd0937b57835808433edc1aaec88fb414e8f
	*)
	   echo "乱点"
	  ;;
	esac
	else
	break
	fi

    done

                # 敌人变强
                tenemy_health=$((tenemy_health + 5))
                enemy_attack=$((enemy_attack + 3))
                enemy_critical_rate=$((enemy_critical_rate + 1))
                enemy_critical_damage=$((enemy_critical_damage + 1))
	if [ $level == $dblevel ]; then
	sbley=$((sbley + 1))
	dblevel=$((dblevel *2))
	fi

                level=$((level + 1)) # 进入下一层
                echo "进入第 $level 层，敌人变得更强了！"
	if [ $sxrange == 0 ];then
	else
	sxrange=$((sxrange -1))
	fi
	if [ $isrange == 0 ];then
	else
	isrange=$((isrange -1))
	fi
                # 重置双方生命值
                # player_health=100
                # tenemy_health=$((tenemy_health * level))
	enemy_health=$tenemy_health
                sleep 2 # 等待2秒后继续游戏
            fi


            ;;
        2)
            # 使用物品
	if [ $dj1 = false ]; then
		if [ $dj2 = false ]; then
                		echo "你没有任何物品可使用。"
		fi
	else
		echo "1. 荆棘"
		if [ $dj2 = true ]; then
			echo "2. 魔药"
		fi
		echo "0. 退出"
		read wp
		case $wp in
			1)
			    if [ $dj1 = false ]; then
			    	echo "你没有这个物品"
			    else
			    	isrange=0
				sxrange=0
				echo "使用成功"
			    fi
			    ;;
			2)
			    if [ $dj2 = false ]; then
			    	echo "你没有这个物品"
			    else
			    	isrange=0
				sxrange=0
				echo "使用成功"
			    fi
			    ;;
			*)
			    ;;
			   
		esac
			
	fi
            ;;
        0)
            # 退出游戏
            echo "感谢游玩！再见！"
            exit 0
            ;;
        *)
            echo "无效的选择！请重新选择。"
            ;;
    esac
done
